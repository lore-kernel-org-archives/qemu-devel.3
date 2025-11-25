Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BBAD10366
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 21:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vO0w4-0006oS-I9; Tue, 25 Nov 2025 16:50:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vO0vv-0006Z9-8v
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:50:52 -0500
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vO0vt-0005dY-Su
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:50:47 -0500
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-8804650ca32so55735736d6.0
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 13:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764107445; x=1764712245; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8qtbVlXGyXzJIVayfd0Yca+xHjo5ZkQQALR6OX+vFjg=;
 b=SsdWBCs3NEnOu91/xy6xkCZUU9pgliOXNE/6mTU7KBtbYiACUbdtx30VTkKEfy5spF
 keGThC3MMDfZ1jbLNiu6eq9KmWSksNoRpgJBamZ1Gr4+PDTdrovBTnXFMBaDTp+wiJIu
 jlP7GNvPO3p0eO34Q0EDEJzGIGo1sfQVUHi0s02k6p/bE3UiXJ9wFCgOxgsdm1Y31QxK
 1dsEh/vUmmw18QRHsb4cxGJWdFKtqy34q76SVur+FjC2/myd/jctF1SwaAvk/17muLip
 5laXK1oZoHcsQb8q5zLjzgU7zwW012Hq95F9jkn8Bayg0AKvH3tN6g35JHKhiFwLnTp0
 piIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764107445; x=1764712245;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8qtbVlXGyXzJIVayfd0Yca+xHjo5ZkQQALR6OX+vFjg=;
 b=hoX1xC2jlye+F5JmV4Aga3dbDj8BixfZJacgm58PK93NZtFgJ6o8UaK8tL1EwhLRki
 6J1rkGpjnLmbMCAhcxSezuE7lbhl9su8wznefLx7C95/cEgXOgW/GqBkDfX2qHuk487U
 WONPGWRxjYGt17WCll2rxOaakymDTx9dU/wOukdE1ZEFjF8vih0IbYtIemsVAjqaaoSa
 RSmHxqlYelkeJFJvoanSLmY0TgcrZ7U+qteE8CJmdwzRPoDip/wiwVqCUll8rmK8ZpVI
 FmnIj2jJVlDNiQl7c4WhlvU8KUcfPwofE4TvTRz4MqZomVJ+wg79MH6/4AmXMfrYVhzj
 t7AA==
X-Gm-Message-State: AOJu0YwRGJ8WwpT9DZwl2tl0thWSiYHv5l5O6U7XUdGH6QDYGWv3K+Bf
 66OI3D5Dkwnyv2KRkm1DaVE+fep+jdBGVsGWjkJgzbvL5zCcxUfDobKEkfX6KLTo4DU=
X-Gm-Gg: ASbGncs5ubWDS80muDKi6IesdK8fSqmy/7CayAerdNCYpQvp9javUyCrfaYyG41cPYc
 TZTiFjIadsybnezcgaU7C+VqX/SPhcavgjHwI2iwwDGPB1ER1+T5bt3eF+01S77e00kAQ/PHQc5
 yZCPPVDTWXObGdzgNtei5cdorapdziLNw4ZwON3Ka6LQKXU1Tj/0+UGusNJLF0eJ0J6MQTGivWE
 Db56LErhlNAhHY+wtGP4KJh/StLhTWnfLlgrG8l/xPjCSPBmHc8SF5WXzsKM7pLXUcdvjNBCSsV
 2awihLkmlNuSzvlEBt/VmbODrQjidJWU+zT0e3WlLvBMG+MrHX03txP7JUwNDBkDewTGt6X1R+H
 TixAWquD/jZzKvzW0Ye/ILBBruAL8avDb3+QXbqZ9C0QyemLgAX8ZZRgOXAVIHNrfpvK2IuejQ/
 lwuy4hU7nKq3WN7B3ajwcglmJG9cSYaToqP+/j9DREX0RfJ6hwglkA3w==
X-Google-Smtp-Source: AGHT+IGjC9F8QxRLUTU6yXe+Drjbkkh6JoOmsX5mki+9YrPVTkSe0F8Xg44cDOXu7xQmoN+ZrNGduw==
X-Received: by 2002:a05:6214:f6f:b0:882:3f45:c819 with SMTP id
 6a1803df08f44-8847c527b63mr266928996d6.53.1764107444639; 
 Tue, 25 Nov 2025 13:50:44 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8846e468484sm131350646d6.14.2025.11.25.13.50.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 13:50:44 -0800 (PST)
Message-ID: <2034dd3b-ca23-43e4-b58a-5815975d2731@linaro.org>
Date: Tue, 25 Nov 2025 22:50:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/deprecated: Remove undeprecated SMP description
Content-Language: en-US
To: Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org,
 Markus Armbruster <armbru@redhat.com>
References: <20251121084416.1031466-1-zhao1.liu@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251121084416.1031466-1-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=philmd@linaro.org; helo=mail-qv1-xf2c.google.com
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

On 21/11/25 09:44, Zhao Liu wrote:
> "Unsupported 'parameter=1' SMP configuration" was proposed to be
> deprecated in the commit 54c4ea8f3ae6 ("hw/core/machine-smp: Deprecate
> unsupported "parameter=1" SMP configurations").
> 
> But the related code was reverted later in the commit 9d7950edb0cd
> ("hw/core: allow parameter=1 for SMP topology on any machine").
> 
> Thus, this SMP behavior is still valid and is not actually deprecated.
> 
> Remove outdated document descriptions.
> 
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   docs/about/deprecated.rst | 14 --------------
>   1 file changed, 14 deletions(-)

Queued, thanks.

