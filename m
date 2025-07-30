Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B01FBC83F26
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 19:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhCla-0002sJ-9x; Wed, 30 Jul 2025 15:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhAz5-0007IE-CQ
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 13:53:09 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhAz3-00014w-Fb
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 13:52:59 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-769a9c3bbc4so71248b3a.3
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 10:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753897975; x=1754502775; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H/HNB00dfQ9wLf8TymI9m6Ih+uoWFLD+8JcesjrnQLQ=;
 b=NcYP2Um2pC/Xw0PtNrHAqBGLMfGh1t8aI10PmfXXJqLOebTslrT3PLVn0DlTFxMSrM
 6kGr+xwiMyz17K/GdyltfnvaVSmiSm10LZ/EWnvrTdnOUxASqUf9Sf3L3dVDlfI+QxnB
 5fWVg0v3t9BnEwUjDRTuIyCdaX1JZ2LX+jF5tDVX82L/BYPlMX9SQbvlDtvA8V5aaGDG
 E5FNhtattEcgXqEf1Juc8MV3FocwXTaesmlbgghQ+1wjL8Fzm8bzKxCYO8Ga39Ks+uYH
 dlp/ujKZOK4FY59j8LQBXzsMnax2VyfP7DnuWOQZeKoqpyGgdkgkI9TYL6Ca0e1d/NUo
 W1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753897975; x=1754502775;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H/HNB00dfQ9wLf8TymI9m6Ih+uoWFLD+8JcesjrnQLQ=;
 b=rLJ24ga1uFRm+8Sei0NxcjyvvnezuNf1qWUH04KG3UTscmBiWwjJ6rJjlpdXmnwF+g
 arpvUO041cYiRM6aG2eXS1rt66BSLHi/rGCAXcOgXc+LLBsA3Uv0QZqTOQkQEWXuxkQD
 n46Mj/19vmgM0DNp2xdaIWJ7yT4iYdzMJddBABtFq14DIoGzgmh8wmllrHm2xuippOKD
 YLuRD6e0O9/SvU6g0XnhFxGSFdHpJf/3iinMinfYNxuDBY4f8gQAB+61Qq9IZWBQZuLC
 IkoYm9wxREYdW42/aC3CNCuJ8GOoAQbmMyr805dDIPsMXKJThUKdiOG9Iz+tFYwbB9Jk
 VqnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhXSzljIO4EIdINzFHt92N/oPQkNMC2hmNmlNCI5+iTj0CdSkqa01D9bEk9kZ/B7rBRT6sFxMmGY2V@nongnu.org
X-Gm-Message-State: AOJu0YwA8iplsk7G4DIY+0hZfL0sVvjI2vt4enw0e1wEh1cS4NZ1CBpC
 Q73CB97qyi3ySWApshXxTV7pOyKImcDgLDMHlHJSRhFGJmpfYFxJPzfaUJgruSRNcgQ=
X-Gm-Gg: ASbGncvgL59OmVRGN05iElhy8f7XZrNkH4OLOf8xHa5c4ZjDRZXEioFGdf5JZ6h/N//
 PXGk+HtKYd3adVL80luo2vgGSgWCUB7wI5gxp44vKYCv4oHPQzqP5v2acTDwb4G5Ff6a0kYYoOe
 7DHvszmWpqYi/NGUWcsNXUaM4eiw42A6eCi4dT23rwOdNKAsl64xRIwXSMPo+CjdgZvEdRP3S9J
 bvYMpSr40tYNMuZqM2/QXRYs1JczvGQmNa3ChrWcq/4AIaFzc4BGynBPVfaNfcKyYNAWEVE5Yz7
 R9t7GNLIdkUy3Cdr/U/qqup7729UUxGq2uiAG0hXK7zAuy1T/3wKpxAkNFG+EMh0T6x01ZbInQr
 /uHt8ct9cnCBMbygMwMFm7Z0zyjdv2v8ajBJ5IiK8d+YFNw==
X-Google-Smtp-Source: AGHT+IEum9S03eoIYPiZWNbDeVKz+k/iAro7TQVOYo5jo1DhqCaddFjxEFKDnx5OfhJVkJ5rvNk9ng==
X-Received: by 2002:a05:6a21:482:b0:220:96:11f6 with SMTP id
 adf61e73a8af0-23dc1091a3amr6814106637.37.1753897975033; 
 Wed, 30 Jul 2025 10:52:55 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3f7f567d1fsm9781772a12.14.2025.07.30.10.52.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 10:52:54 -0700 (PDT)
Message-ID: <db3ba3fa-1460-4ac0-9054-7c466f98ac6c@linaro.org>
Date: Wed, 30 Jul 2025 10:52:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] contrib/plugins/hotblocks: Allow limit to be set as a
 command line argument
Content-Language: en-US
To: Alex Bradbury <asb@igalia.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, erdnaxe@crans.org, ma.mandourr@gmail.com
References: <cover.1753857212.git.asb@igalia.com>
 <58281d6e54bcad1802e8d3dc8d8501d54c2a971e.1753857212.git.asb@igalia.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <58281d6e54bcad1802e8d3dc8d8501d54c2a971e.1753857212.git.asb@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

On 7/29/25 11:41 PM, Alex Bradbury wrote:
> Also add documentation for this argument. This allows the default of 20
> to be overridden, and is helpful for using the hotblocks plugin for
> analysis scripts that require collecting data on a larger number of
> blocks (e.g. setting limit=0 to dump information on all blocks).
> 
> Signed-off-by: Alex Bradbury <asb@igalia.com>
> ---
>   contrib/plugins/hotblocks.c | 10 +++++++++-
>   docs/about/emulation.rst    |  2 ++
>   2 files changed, 11 insertions(+), 1 deletion(-)

That's a good idea, thanks!
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


