Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A2ABC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 10:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJWAU-0002jp-FN; Tue, 18 Jun 2024 06:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJWAS-0002jD-L3
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:34:24 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJWAP-0006Rl-H9
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:34:24 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-52bc335e49aso5992904e87.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 03:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718706859; x=1719311659; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GFrLfmZ3dCktUW5KEOigHrMB0tykH6fO8Pux4z2UNAQ=;
 b=P97QMWwF9k6DtJcdswPsxVg0srgbCKxo3+iLZKyDDtNKu+V90LMkeOas7UHLClpaZp
 jje8DjcztBWpLAzy5glSywuVK4kqZ0JajRPYyuDCxo5eO9E+NGB4fVO9jztj3K2ncFjr
 fhtL9IyMoQNIlk68vTMYbeKMy9leuxUfC+fkPst3LFmOhGfe7k5K+wywC6toVkYFcHH1
 CrAGXCr6fHAz6Omk7xclirDL2WF+bQTcmAafjXrXQ0+taX+quV00xSxfcjA/W7WjVkyM
 YAYkcyb/RS2RxwUPUcHB6MRB7vgrZ55d0UsgcgaIMBklJzDnI5OslB73FtmEEvovr+pC
 u/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718706859; x=1719311659;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GFrLfmZ3dCktUW5KEOigHrMB0tykH6fO8Pux4z2UNAQ=;
 b=OOabJE7LQSvv5upP62YrjuP+jgrVdcLtdXpmEtnn24MbcxqQ5p9gzlQjR+YHX8LjJJ
 Enf/Wv9/R+gs63WZAL7QLEW9s25/tHKaFsbVQ0c+irTHW+MzcX2wnmpfucCSOXJky8j3
 Mc9GyM0hBM2x/xCjwyt3Tl+7uUQ2vtX5W7g0jzuGm0GnUT4H7zmnYagHTC1ofozInsth
 FPrU8h+sRsV298nhqgnnJpVFTlj4LkA1exj26AGAz5RBM2efql8P1B4UBA/mIqb8p4mw
 KaAlu9Qva7KeD+s2MsnCw1OnidJM0ewvIs705btxCjMg4rxHc7KMaKv8AwYXr1cqyDO9
 BIFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV72rW0q6UTsW811kTBMrxZB44YH7wTw6P+i7TuAjFETQ85Ki6O8xAeDqErYImmCAJTpOs9K4apq/38l+1d8d+26c/vwa4=
X-Gm-Message-State: AOJu0YyktLYh1tzKZE2SZeg4K2nEWZH3MZ34urj1+CbkNUv6F6de5lI/
 Cx+y0GtZ9jh/WCCpHoEK6jrR+EdKVtXhBa6tad5eB+/hVeu05rMDoHUjOh9zFB4=
X-Google-Smtp-Source: AGHT+IG70IyVhXNw1I10h7evbBV66OOEEgzFSYYGaNxml4pfwmVlnSlGmPI3XqGjl2i7iFZpbltCbA==
X-Received: by 2002:ac2:5394:0:b0:52c:9e51:c3f with SMTP id
 2adb3069b0e04-52ca6e9467cmr7601294e87.42.1718706858879; 
 Tue, 18 Jun 2024 03:34:18 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36094fa7ea8sm5258923f8f.80.2024.06.18.03.34.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 03:34:18 -0700 (PDT)
Message-ID: <f803b768-91f4-4853-83bb-65a190f5685b@linaro.org>
Date: Tue, 18 Jun 2024 12:34:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/13] qapi: clarify that the default is backend
 dependent
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org,
 mst@redhat.com
Cc: Coiby Xu <Coiby.Xu@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 stefanha@redhat.com, Markus Armbruster <armbru@redhat.com>, slp@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>, David Hildenbrand <david@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Brad Smith <brad@comstyle.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, gmaglione@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
References: <20240618100043.144657-1-sgarzare@redhat.com>
 <20240618100043.144657-2-sgarzare@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240618100043.144657-2-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 18/6/24 12:00, Stefano Garzarella wrote:
> The default value of the @share option of the @MemoryBackendProperties
> really depends on the backend type, so let's document the default
> values in the same place where we define the option to avoid
> dispersing the information.
> 
> Cc: David Hildenbrand <david@redhat.com>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v2: https://patchew.org/QEMU/20240611130231.83152-1-sgarzare@redhat.com/
> v1: https://patchew.org/QEMU/20240523133302.103858-1-sgarzare@redhat.com/
> ---
>   qapi/qom.json | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


