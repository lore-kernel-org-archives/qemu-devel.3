Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1165CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 07:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSVCH-0006nP-Ve; Thu, 28 May 2026 03:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSVCE-0006jE-M6
 for qemu-devel@nongnu.org; Thu, 28 May 2026 03:30:26 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSVCB-0004Jh-SH
 for qemu-devel@nongnu.org; Thu, 28 May 2026 03:30:26 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43fe608cb92so7634376f8f.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 00:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779953422; x=1780558222; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MIYOm45HKLIkfZLveq09PjDarV95RI0539rL5PJdKUk=;
 b=cl/eX3o64q2V40a2kPAhQjJCYvDO9KRq+gBVHNzTcGWDpkzxio1Kddn2JD0zlJu6eA
 FeTvSeR78hvV6qH9WQVXIVta+uM4pcgZCP77x0oLQTSYHQW8N5r9zLHnkKQjZ59EspPI
 vU71b+hw97BmQhEXKSaUn2SGqN76wtGZGss9syiZkMuIrw0R8dC04aMoqhCKZKClbOtu
 nk16ZZbGD/iWqDJaL7qO3Nr3zkEv7phgpTXyfU5EAHoGjdtmgudEHyY0ZUNAzTtUpoyO
 GIFjcEzTnC3GBqbChJTcdpg2mEbZtlC0a5u3ezaZL37q2acgXg0tIUnLAC/B42G9JSru
 IVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779953422; x=1780558222;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MIYOm45HKLIkfZLveq09PjDarV95RI0539rL5PJdKUk=;
 b=CjsQtfA8aPtIA3rSB4TgJ2wZKRMGxZUMO/r0EB0o4cJnfvpWfSWM2hKZcWKaxxwdlL
 OApto2Uw1+5J/DyM0Ldsv++RX8VXETyZpBoLBjYvBbq3/RjS1NDrjZWb0OpQcgbd9QPI
 +1cgj98IZI8cf4J8VDaNG+E8MttICkWO/vlt9zNL3oUTQfJ+8hrk0bporzyNsr0VmfTc
 X8go5NH32QJXx0puy9BEc2tmI5KQouZEkEZnECF2engZBkZ7CwKR6UqrOYxg4vbcnahL
 nkXgxS8mFUNWTzIvKR3uFKzRFS1mQZb35OqzgDb4rGdj9dS9H/BHgK40wyhb+fdhuThs
 2aXw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9yH+V4YCxHiWDknWZEb3eqa/6hTkmA5ZkeqidfijKCUTUWkj+dSFUzi1bKURnsPTMg5xwPziqjnMsC@nongnu.org
X-Gm-Message-State: AOJu0Yw5YySDgrF7GoUL6f05U/1hb9bqDDVSF6DDcjx6jC1gAqJmcyqK
 WFZyhplBT3pJW3lpoXV+h5V4k9rnqj/bzSa5J2h5fd5/baW/sAMwR+DqK6d10BTibzE=
X-Gm-Gg: Acq92OFabHqQ8EPe0t5hFqPX3mVclj4PQbxelFgur2eZE1QDV8UFl8fPF8SPGp2c+GJ
 Gdh7QA5K4dCdOl8XWMBL1Pidbyqr9B7nD/limWLtwBmZKkwyD/dleIu/OR0rescAXfG4lJD+5BF
 p1GmQI9V0/Wi4bP5yT8hfnoArWEyMzaM/ISbLpcoHCBjRSu1HHiCWa6bIGi4aDRGj+5P1Jp9qVC
 L8/s/kv5m6WV96+NrOQG0HviilT57TzihsjZ26vANBAASIP6c8Us1Iu6MTI3TZ+Ilsnj6+8jB99
 RPmWCIKr+PvADsyj60jhldmopfGT4H/rXrJ3HxwvOgzSsfuA1swOZpxTEFg3RhMigzdySLJaBE2
 u0WuRQQM7SCecVhc5dFR3zn1xG+8dUJ1kAALwEp0SKG1twS3tWvE7fYkqvD5WzDr4qsCZPY/U5B
 A9wTMo+4umoSPaejj0lnSmwJ1AUI/S2TFAiMSES45yTpUusM6T5QWmoQrboqQDE9DGHLuJghtyy
 CAw
X-Received: by 2002:a05:600c:a402:b0:48f:d1c0:721e with SMTP id
 5b1f17b1804b1-490426b294amr300869545e9.12.1779953422014; 
 Thu, 28 May 2026 00:30:22 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49092a925acsm38797545e9.14.2026.05.28.00.30.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 00:30:19 -0700 (PDT)
Message-ID: <9be6fb5f-c75f-45ad-b8db-658037946e19@linaro.org>
Date: Thu, 28 May 2026 09:30:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] net: use stub_ss for vhost-user-stub.c and
 vhost-vdpa-stub.c
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Weiwei Li <liwei1518@gmail.com>, Helge Deller <deller@gmx.de>,
 Michael Rolnik <mrolnik@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-arm@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Glenn Miles <milesg@linux.ibm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex@shazbot.org>, Brian Cain
 <brian.cain@oss.qualcomm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Jason Wang <jasowang@redhat.com>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Peter Xu <peterx@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Nicholas Piggin <npiggin@gmail.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20260528051642.115721-1-pierrick.bouvier@oss.qualcomm.com>
 <20260528051642.115721-9-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260528051642.115721-9-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 28/5/26 07:16, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   net/meson.build | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

