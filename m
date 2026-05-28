Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A9DCD5BD1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 07:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSVE2-00008j-4q; Thu, 28 May 2026 03:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSVDq-0008Lf-N0
 for qemu-devel@nongnu.org; Thu, 28 May 2026 03:32:08 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSVDn-00068A-Ca
 for qemu-devel@nongnu.org; Thu, 28 May 2026 03:32:06 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-459bf19e87bso7483863f8f.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 00:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779953522; x=1780558322; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9LWPOs2Ju2J8pG8wru04Q+1RDnSE64nD1JGRnbxc5Ks=;
 b=SghT8nm6dTZYLEhndLtBn68lCIEONyuBYVO76h5ZrUn2VUaT6zE6VScjeFv7XkkFgI
 9yc2I9GdlCh/pwDXrFQussY20Y5Clh+dwKcvtwbeXFcuhNfYyZfvQ2DwBRE4cvruQDtB
 pDlBk9vn4cgIqtgYjiXEyuuAPWFZIotiTYnRCxsfPFWTGIH4rjr+JdHcGr0/ryvPTi1t
 ocoxf1NbhL1SQhCjjGyWyzH11/NPzkRsCtL5cRLczmNAvaHliI1gbM389YRwr3wRgkFq
 Mxto4hSl7y2oOJM3JEN7Yr+SH1w7Cq1l4JNrFcshhwV3PwUmR6rEbESPXAjkaawNzD8s
 mIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779953522; x=1780558322;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9LWPOs2Ju2J8pG8wru04Q+1RDnSE64nD1JGRnbxc5Ks=;
 b=W4epXdCpgLrMIucEznQ6hnJacxElKJpPb4oqTmggl497bFcgEm7MZo0hclF/FOgUNA
 JQuTXP2na/oW2uZY321zT+2K9vBK7WK31okLAxXWZzztskJzmLTw6l72vZNZkGrk6CnH
 bO/kj8+1WEOxb3dMR93I7ofBl0iUzfUqliLC84UCSJvogwyq4OETNbKHXBKmti+uRyu1
 /lCrn3s67UXDsPsT8ofC5ok0VHIX99EXwA1jvkwua4KOqOD8qUSbyaHQlI4ZNr6oc54o
 i7GnVGWrTaNwiSK4Tomta6VG7NsIzD/65sHEyW+VDEgA/RyIuvbZP23mtxNQFyYG0r+2
 An9w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/AUovd3URY2Rszlm1hCEcFT9lidRfMEPYOTIhwO2hQbk2PfBOCsI8pX6MlB9WXbyuDhSjOYsF6zq+R@nongnu.org
X-Gm-Message-State: AOJu0YwKE4GAigmpX9+2PympBdIaVj04031dX9xPhWThHYHdSGTifx3g
 SHypuOCPmAIgrXZzeBy2uHsvxbe/TIDYrteVOev/BqyFLazpSs3LCYnwlMOEpDT/GZo=
X-Gm-Gg: Acq92OFWan8i08jWEshQsIk9zvih7RvIy1FcaIaVyK5YUDskxQaOQIqIGGuBxRJb0zG
 3feFViJ91P5hVZCGDtQjeXEqbL0REAEBp4TcDURXciS/s0n1KMJ6DIfnZZvpUnd3sRu0xRVGO7k
 k4R+wDny6RJelr+Ni/RDH4a0MIm7+608vQg7bdwGd7ML6/G+MtLklkFHau4AzKSHLeA9jC+tReC
 TL4Vi90UK3YRBzPfsuV0bU2Wanl1z98MkOfELGiyAeEUfvZ2fXZyClWQe8DrEP3J2UUks++QMcP
 8oELSGBdwtD1yLS4rvCog+U/LQGEEMnVU9MqycrnKK9FWPYdq26dwTnlew9zxoLrHQxl5qxuFW4
 zg+zNa8ZFr2hB4n2qSxi6XSfO7ecxR44UXoWmL5VU1t9MvQpXAGbcizlu2nU/5PJhqcNHuqmKMK
 mbtIOn6oNdzhDEoLXt7WYdTPb/H/tV2T1Uvo56aAmbRIdr8CpQR9yu6JjFUjHxVyAIoEi/5dTFu
 H5i
X-Received: by 2002:a05:6000:400d:b0:43d:1cec:4766 with SMTP id
 ffacd0b85a97d-45eb38c52famr42422051f8f.23.1779953521738; 
 Thu, 28 May 2026 00:32:01 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5b1c7bsm11594438f8f.29.2026.05.28.00.31.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 00:32:00 -0700 (PDT)
Message-ID: <6f46ca78-26dd-4de3-85a1-a73a7509dd28@linaro.org>
Date: Thu, 28 May 2026 09:31:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] meson.build: move some subdir before system lib
 creation
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
 <20260528051642.115721-6-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260528051642.115721-6-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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
> Allows to use stub_ss in those sub directories.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   meson.build | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

