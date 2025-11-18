Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1F2CEBF93
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 07:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLFxm-0006Bf-UU; Tue, 18 Nov 2025 02:17:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLFxk-0006B5-Rx
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 02:17:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLFxi-0005Hk-Mp
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 02:17:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763450232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=b7F9CGE5VrsI9mrbrzbIFD5RjxyTpNhuIq/05wKSST4=;
 b=a4U0DCPDWTydBFj2hb9eW3FcqIFagzb8td9pKdktO/99MqH41aDzHjEiIUFLiUgzIoB8D4
 bRDOuRn2oy6zyXud6ULhthbaeIUKeYYwPrdVqivunzKFW9xtyc6/AS5F/gfS/tJTGCrNw8
 A2TV8zB6osxa23wCK10+FszPhvhE4Iw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-s6-37qNTMEa4DFlwgqVvNg-1; Tue, 18 Nov 2025 02:17:11 -0500
X-MC-Unique: s6-37qNTMEa4DFlwgqVvNg-1
X-Mimecast-MFC-AGG-ID: s6-37qNTMEa4DFlwgqVvNg_1763450230
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b6d4f19c13cso425852966b.3
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 23:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763450230; x=1764055030; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=b7F9CGE5VrsI9mrbrzbIFD5RjxyTpNhuIq/05wKSST4=;
 b=cqOTC9wCspBoYCJ3nGY4SCoPIqAptI+5zLdKCo19TJyc4tRXEfNRkDOitu9j/oc01O
 IfTUHlsfF5Qx5D4rnqmtLOfhFi6+oKaeQReOcJJdr9PJEC6aSrztskw0wcJRIH/Xqwon
 SR7kx3es6BiD/CQmFx2DRyOGIz7uE/Y/QMbcZ8ilkQdVY64TidS8Yp/S6Y0ssj4nIr4R
 rh5EFHE2DlY8xIFZJdRy38lfypUJ5Ebv8tVBCsAHyrYaAp4YbyIUG9MF1INiAHL+KUjD
 /58/ejxR1MhaimmEfwHA5xFcERkhIIf/E9Gag0yUkr1ReDNC2Cf4F9fJL4800SvlYa5j
 yJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763450230; x=1764055030;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b7F9CGE5VrsI9mrbrzbIFD5RjxyTpNhuIq/05wKSST4=;
 b=Vox3us0rCj0zY03+lKMbR4SdKUsZBODmfcerrSYLI3IMauWy7hDv8AVZcaWfg0oHU/
 FS5lCi4ZOrC79o1iw7gnWXmah6eAwNfbqFcgGQhaSASrcJ4XxkZ7LL0m3pcIDnkFQNFN
 FVHVF+x32QeYJpZTvdautHNpXUYora5zCWB8Np6xMg162YSyFWHt5VcewEdRHZbaQTbZ
 uD7M3sEc+oApw/BmiB1r0AL4oUi28lwphOjCkGjRLJCy6O/yBbxOy8ANZX6TBhOgFext
 5Xq7yXSpxzAnUNQsaVcsqFYt2XGv/fuyBOXAGgdYtq6cI+msxzedyDK+ObXLBevf8Jwu
 4z6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdNRcUNY7pAd2sNNp1R2QEu3knSzlgNq8sviUs9e7VIGb5ukzpvnfupqXojWk6LjKTb73KiY1Y3qNA@nongnu.org
X-Gm-Message-State: AOJu0Yw82vC64iZsBF0w46FJANwkoX8rDnFwoYOkQqckUSUeaqE+rufo
 v/W1hl25O6kSxUHOZxabhmaOFpIK9lTKRxCRnwbrWYSMwmL4fejoMf2Xd5kPe10qMpnVeGFdTn1
 v+fGy93Bn4CBM1NFRBtDf5/M7pcMHCQpQsYnPtqZIYulVlBn+EjemK/rn
X-Gm-Gg: ASbGncs2BBz0yw6pkXikFFuo+4Zn42sTfswqmXuq1w1Aq2WfWXAjMCRRk6YRn75qCCD
 L0OfG3Skv6BgiM4Z6QAbmncT0PZbDkkh7WXEuCuTUPdxl+8zwqEVmX5uwa7gR7PQjTfK0BJQy7l
 +jH0diFff4kqOUmHKnnFdNZ21h4qBfuzJYTkluvqo15VWrlAUWmu+ucEWBlJx+S6gpX/EUAOO0n
 q6rYM2fy6C7M3MxRozeLmrZiD0JXGd2QyNrO4VpLYIthFrNu6eTFdIbRW8YRHcqXsyhnBkSI0Kz
 Kb1o+X0yhvHciOsON25gYLMpGHqM2z1VTOHCgknl+NkEtCTsv7uo+55MSosgRdaFsZMYrG711e+
 OpX7cdaY=
X-Received: by 2002:a17:906:ef0a:b0:b72:7601:a321 with SMTP id
 a640c23a62f3a-b736795d6ecmr1555800366b.57.1763450229958; 
 Mon, 17 Nov 2025 23:17:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgNtoMrpQkB0upub3KOLMQpIg93WqoFlRAGxdjD+SpTlHXmGCc/6l5LYgaG6Ax2OwJ9a52nw==
X-Received: by 2002:a17:906:ef0a:b0:b72:7601:a321 with SMTP id
 a640c23a62f3a-b736795d6ecmr1555797966b.57.1763450229607; 
 Mon, 17 Nov 2025 23:17:09 -0800 (PST)
Received: from [192.168.0.7] ([47.64.114.102])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b734fd809d2sm1297362166b.42.2025.11.17.23.17.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 23:17:09 -0800 (PST)
Message-ID: <ae473578-b975-431d-904d-8cea62df6e37@redhat.com>
Date: Tue, 18 Nov 2025 08:17:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/22] tests/iotests: Use configured python to run GitLab
 iotests
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20251117185131.953681-1-jsnow@redhat.com>
 <20251117185131.953681-10-jsnow@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251117185131.953681-10-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 17/11/2025 19.51, John Snow wrote:
> use the python (and the pyvenv) to run iotests instead of the system
> default python3 interpreter.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   .gitlab-ci.d/buildtest.yml | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index 44df116139b..c3a9e8428c2 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -351,10 +351,10 @@ build-tcg-disabled:
>       - make check-unit
>       - make check-qapi-schema
>       - cd tests/qemu-iotests/
> -    - ./check -raw 001 002 003 004 005 008 009 010 011 012 021 025 032 033 048
> +    - ../../pyvenv/bin/python3 ./check -raw 001 002 003 004 005 008 009 010 011 012 021 025 032 033 048
>               052 063 077 086 101 104 106 113 148 150 151 152 157 159 160 163
>               170 171 184 192 194 208 221 226 227 236 253 277 image-fleecing
> -    - ./check -qcow2 028 051 056 057 058 065 068 082 085 091 095 096 102 122
> +    - ../../pyvenv/bin/python3 ./check -qcow2 028 051 056 057 058 065 068 082 085 091 095 096 102 122
>               124 132 139 142 144 145 151 152 155 157 165 194 196 200 202
>               208 209 216 218 227 234 246 247 248 250 254 255 257 258
>               260 261 262 263 264 270 272 273 277 279 image-fleecing

Reviewed-by: Thomas Huth <thuth@redhat.com>


