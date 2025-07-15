Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9FEC83F2D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubc8u-00032D-Tu; Tue, 15 Jul 2025 05:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubc8Z-0002sC-An
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:39:51 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubc8X-0000od-8Q
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:39:46 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4561607166aso16366665e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 02:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752572383; x=1753177183; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jjjuy504ji/tUVUlqeKl4wSNDow8k/R7X9xDNZWM+64=;
 b=hbsEOiodJS3d3SYvaP7e7cIK6TvDlDHvhH6huyBc4JdzD985f8zKbLT58+qd6ZLytx
 Vv2s3IuuSTV7f/iatAN70EIzNoEJmJn03bkHoyUAgTGEzf/AMS35qBe6s7JyFlFZfD8R
 aUymogvttCjrDEv1hsVa+uiQOGkZl7+BPbYmUXi3MC5HuLYfQxmY/FjiMO4WYMjH+gWA
 qO9xoxtOmhmmzjouLGULJWhOjYTk7SXLmXnYYvpqwMpEYCtSZnlEZLe4kTti+KuhuD/g
 qYUwpx2yT/nD57lh699GdjoLosA6UrWizthn675S/AhMkUMdZbxJaCj83jjTXKBo3qTw
 j/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752572383; x=1753177183;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jjjuy504ji/tUVUlqeKl4wSNDow8k/R7X9xDNZWM+64=;
 b=kjcRFBvE8PczXHlcVD8oSGXg7/Ilkax/8ZcuZuNACKe/eeqq7nQTyOxm2WYzKZoEQ4
 aD+69RlpGMnPdMApbLsuBdQWIzJ1GoSLIF/eCH40usYdGLew1OF/Jmt1zwffpadnxzNi
 jwJWtkG7TMeztMvIQa6BITUvYi4OBKKYWZyT693AIkwWIgwXTk3xN2F43IM3PnbNIhPn
 BpNRB2oxtaU1YrqlJCNjzRjdFhD/xEjsEnIAzmRHEUNrtgP9FVyOOkOowLRwzVj+3XAo
 4cVUdzH+yX3hfJX3SN8A+k3LS7esATUpCsViz3JTmIGoPDu4O4gL+6auUVDR4b6emUwW
 /eFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDGKPn9IhGWitPH7dtkbslu37VfTRRql2EJZdA4IcCZkOPJxwkr9fqUCqHgrB8cUVg1navWyYHbJ+E@nongnu.org
X-Gm-Message-State: AOJu0YzlAnr5dIChxaMvvezEpQ3pTbHEKmVYod9SgqF1yq1AEZcGr2VV
 TM2DJCGkM+M/xwu+wtauJurnIhXHUe/mDZmaGfSvHSZ5FQDsqGl5SK6eZ7li4ZP0bt0=
X-Gm-Gg: ASbGncvEqcb7+8F+4IR3X0/TyrWI2+fwMnxn35lKkjxTVglv2ptaKfBU5O4xWFYcwlF
 2ww78Oo3r5dy8Me7ix2i06lPHTPyfqHIZ20grf2IVyCY3ikK3N1QuL4Js7To3NyfJQ/s89iAx+l
 kFrA9ygWsPrwoFSL0zjPEzCWAclXPQ0iQ4zWWOvL78+ZWQ2o2uKa0UPijMLkOX/UPWLIZW0QPsY
 GtXbGj9cHjS1syKtMqLMiHJfrUkTQYxFj/0aLBZt2SFGyuJCuoQAZHC1TwUxDHjYQ1+eNAsknE7
 Eiwu5FfKieM79RljU3iK8moaeYpmYczAX5NNhis1dVCHILMmCGhlolsCknLpAYlWmWO4SntGuPo
 ZEj2ZJG5NpHBqg2V/oGuTE7SHJZgSWofXp1iYywMpfxeRXqrUo1YQv7BoUAzhXqQ8ywzVKNg=
X-Google-Smtp-Source: AGHT+IE93YOzgKK2qDmtm0bhjHFH6YDWYIbXmdo9izG6/ejBFYzCX5D/JpyDv+FSErjXEVUnCSSy/Q==
X-Received: by 2002:a05:600c:3d8f:b0:43c:fbba:41ba with SMTP id
 5b1f17b1804b1-45565edca7emr117032545e9.28.1752572383249; 
 Tue, 15 Jul 2025 02:39:43 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1e8cfsm14260441f8f.80.2025.07.15.02.39.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 02:39:42 -0700 (PDT)
Message-ID: <4c0486d7-a7f2-4ffa-91eb-6d64c0c32064@linaro.org>
Date: Tue, 15 Jul 2025 11:39:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/22] vfio/vfio-container.h: rename VFIOContainer
 bcontainer field to parent_obj
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 danielhb413@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-8-mark.caveayland@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250715093110.107317-8-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 15/7/25 11:25, Mark Cave-Ayland wrote:
> Now that nothing accesses the bcontainer field directly, rename bcontainer to
> parent_obj as per our current coding guidelines.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   include/hw/vfio/vfio-container.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


