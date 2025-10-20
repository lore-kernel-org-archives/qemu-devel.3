Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCDECCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 06:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAj6r-0001JR-6w; Mon, 20 Oct 2025 02:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAj6p-0001Ge-IG
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 02:11:07 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAj6n-0003e3-VV
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 02:11:07 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47100eae3e5so36745595e9.1
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 23:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760940664; x=1761545464; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BXXOrptoc81LnYXKppppXYtM6aRpFMZHfbgbW/Xv7a4=;
 b=e8Q/hkx1Jsc/yMZQMkedo1RRSNO8t8n6R/ZCje4iox3aqJopq/0uI33JLcn1qxp/5Y
 L+x5CO4MSZz+OuvqaFc98pkstGlZUXKhuWj9/rgTOlbSSqFDVzlTb2kXMsbqHHm/y4ol
 ATDpnX98l9caKevw9tt+Ip9scv7uhebUTEXHmqrgdP9mvQQQq4EDXr9H3jfHG6O+YtMB
 jRFzFrpDCQ4KErBao+Wzscy4clOd2zSO5OYTrH8Yrsy6HCCWjdJp+pfseVtes+8LzgD1
 6Frwy16Amv558XsK37T/P1OoG47S83jhzGGK7vKTwAOewyiYCchCHTgc3dCoc3DwuqeD
 +sUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760940664; x=1761545464;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BXXOrptoc81LnYXKppppXYtM6aRpFMZHfbgbW/Xv7a4=;
 b=M8adw3NkVdrICAw0EFJtWhKZx6RDfQFpmdqvGhpMmC3HTaY/zv0c/g2+fy6gCXc1q/
 6+6YUEaC5PVKzVaeEKB2T5t4X4fiJ0VZugEFSpkeUVGCyIWMXCZZ0SQAxP8vbisgwsa9
 7M4SMvPPS8Fqxl4hzvbL98Hsmk36E1Vd2rNQc7lNgYhPbO2x2DB7lqqwRRVb3AHT20fT
 ubij69L4T9dllKEdOlyLQtruoJl+n7CCREI9pyE14Awiko3tlEUis92BfmWyELRKJnC3
 IVNdg2B0IpfOHW4TT6G9lL2lC6XQ60002Q0RDTgqpJ+IGftgE8UKIDD10mg24kzLT6mq
 TU+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjw1uer+LCmQsZdSPgXsfpSI3C8EeXjlc9tUwjI/g0FxaaNJOoaMISZ+7U9zAEo42VoBUjlaBP6Fma@nongnu.org
X-Gm-Message-State: AOJu0YxH6N95PsLIgOTZL2nWvSgFeYh3ReNntI9kcXm4GNe8WXSmeAUN
 eMvoa2CGSuTshJhN5xSAnTEw6nTKoqEAOwDJx1Qcvu6sugPqQVWvqFsB6L6lH559tCQ=
X-Gm-Gg: ASbGncsgcNjaYa0d6IQr8PT5zRo3+S2df6mzog2sXjaMkWs+0PfCxV6vtKHa9ub8lIz
 uWUEAO8immWgMCH3WTQAIbusHwR/tnyFvOMPX/h5LyESiBaEL3aqFE0EzVHOmUGjzCdJqVI5Y7r
 N0m3zDLa4MfH1L3oxoAllRAPMWIvh+OL0xtAtqx6mLM4QZO9lT+HLOBFYHLErFL0x+gf+28y4Or
 N8wDw2fKNOgHff71UiJs225NvFce6SejxL+knwibfcQa9h8exDty/cIC0RrQW+waMunNayEP4iw
 wa6X87CTtpVFmBwi7F7TCceTdOSGgbkJVDFL/ruCf8+Xm69NMo5Za/8UDBeL/bPfAL8NxCISGuj
 c8RW/tVSKkXvKwYXo4wWq1WPWYS+hGBEeNX8nVvtz5EJNffgA/ctG5hQuJkTMCEd7ph0vvQHrHr
 KF8MAtGV+ZJdCJdNaRJlLXr0aDiR4FYDzfhCbrGArIHLqowV+s5GvNbQ==
X-Google-Smtp-Source: AGHT+IF0GrnqoFiHhiKe1Ey1S/CfiDmlKMI9HdKRO5gAV9PLkQgkhZmoQt3Osb6YwY7GwqbTcbMXmg==
X-Received: by 2002:a05:600c:3550:b0:471:14f5:126f with SMTP id
 5b1f17b1804b1-471179141cfmr94029375e9.33.1760940663812; 
 Sun, 19 Oct 2025 23:11:03 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00ce3e2sm13494720f8f.47.2025.10.19.23.11.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Oct 2025 23:11:03 -0700 (PDT)
Message-ID: <127dca3e-bc84-4626-b0bb-50eb5267f878@linaro.org>
Date: Mon, 20 Oct 2025 08:11:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/10] tests/qtest/ds1338-test: Reuse from_bcd()
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 kvm@vger.kernel.org, Michael Tokarev <mjt@tls.msk.ru>,
 Cameron Esfahani <dirty@apple.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
References: <20251019210303.104718-1-shentey@gmail.com>
 <20251019210303.104718-11-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251019210303.104718-11-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 19/10/25 23:03, Bernhard Beschow wrote:
> from_bcd() is a public API function which can be unit-tested. Reuse it to avoid
> code duplication.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   tests/qtest/ds1338-test.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


