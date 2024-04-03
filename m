Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4338CD1288
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 15:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rs2mG-0000Ni-Ou; Wed, 03 Apr 2024 11:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rs2mE-0000NT-Oj
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 11:43:50 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rs2mD-0007m3-71
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 11:43:50 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41569f1896dso21273075e9.2
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 08:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.com; s=cloud; t=1712159027; x=1712763827; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Y9Sp/OHQl7LX0HvfCuA51fjMs6lNI8EXuXJQcWV9ReA=;
 b=hgX23zbxZACIG9jkklMN+8vZZNO6RpefgukztnuFMrzHAz0LjVRsx5qqcFBC0NcDQl
 zzMYGukcGko+TPyNHR7e1avvgv8pZKEJeAMLsrRj4f4etgDRcvXiBGL+yuOvG6EEMeJq
 w71dYbVztzODowL12JoQOXmaBylrVV0qHjZG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712159027; x=1712763827;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y9Sp/OHQl7LX0HvfCuA51fjMs6lNI8EXuXJQcWV9ReA=;
 b=ExCsRwFhvGwDZRspGOT5MjNBZIEw7CiBCEIeaamjyk/nr+Dd2nUr15nm2E0HSyTuLT
 IJkAi43jk+kNHT3ItkRq6cgfx4gE7bkQVwEuKY012t3TPsPsJCSXMxfWNn+Sckv66Q4B
 et4t+oaAIWIjmoXJdC1TwFax9RI7EImKPAPdQ0u1sSIAAyvAfQ/rQfDllVYOrH9XgLZs
 G+Rc1WHr0dZwolEnq+e1cXeWj6wk7/jhvifu0g+5iJi78jrudCYYDotA1iLfjBDCo1d7
 mLd6mHiiCjCs9OT/2Kuzp/rTwiOH5ew2KBEczFT26c3EBu9oi2JlviYHU3mhuGaJN/gz
 wVCw==
X-Gm-Message-State: AOJu0YxCa0zrt8HjZ6rFgFmu9cjgUJHz8OaMnxAZ5QEhovkWtYDq61OK
 ScqwUBkI51ENgzQ3to6Ua69hMWZLPu9v6ADvYXy+BRlo55zmmABWfZtrnyw2b4qt0mvlsa6sLIf
 t
X-Google-Smtp-Source: AGHT+IF5b8HjXApAcpQwe/1kkOZl1c5PJHbxIW52Fl5orkLlISVOTSBTRKkbtyWMo1dODw/9n2ekQA==
X-Received: by 2002:a05:600c:3c88:b0:414:7e73:1f5b with SMTP id
 bg8-20020a05600c3c8800b004147e731f5bmr28842wmb.4.1712159027053; 
 Wed, 03 Apr 2024 08:43:47 -0700 (PDT)
Received: from perard.uk.xensource.com (default-46-102-197-194.interdsl.co.uk.
 [46.102.197.194]) by smtp.gmail.com with ESMTPSA id
 fm15-20020a05600c0c0f00b00416253a0dbdsm1325954wmb.36.2024.04.03.08.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 08:43:46 -0700 (PDT)
Date: Wed, 3 Apr 2024 16:43:46 +0100
From: Anthony PERARD <anthony.perard@cloud.com>
To: Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?=
 <marmarek@invisiblethingslab.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul@xen.org>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v3 2/2] xen: fix stubdom PCI addr
Message-ID: <a7ebf899-1078-47b0-bf03-ba5503dba0e8@perard>
References: <cover.527f002866de2be7c275c5000b6e5edfeb7e8368.1711506237.git-series.marmarek@invisiblethingslab.com>
 <35049e99da634a74578a1ff2cb3ae4cc436ede33.1711506237.git-series.marmarek@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35049e99da634a74578a1ff2cb3ae4cc436ede33.1711506237.git-series.marmarek@invisiblethingslab.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=anthony.perard@cloud.com; helo=mail-wm1-x32e.google.com
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

On Wed, Mar 27, 2024 at 04:05:15AM +0100, Marek Marczykowski-Górecki wrote:
> When running in a stubdomain, the config space access via sysfs needs to
> use BDF as seen inside stubdomain (connected via xen-pcifront), which is
> different from the real BDF. For other purposes (hypercall parameters
> etc), the real BDF needs to be used.
> Get the in-stubdomain BDF by looking up relevant PV PCI xenstore
> entries.
> 
> Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD

