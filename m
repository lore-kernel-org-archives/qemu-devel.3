Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C7CD44D74
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 14:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8gey-0002HG-Sc; Wed, 06 Nov 2024 09:05:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1t8geq-0002Dl-A4
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 09:05:16 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1t8geo-0003dA-VF
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 09:05:16 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7c3d415f85eso1003151a12.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 06:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=roolebo.dev; s=mail; t=1730901913; x=1731506713; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jrcpFSjgvzzujI+bhzhH1nSAHlFEG4p9iq2XiwLK0+w=;
 b=HjJzwjNu1vueU8p437k4AQQ8k9yQifoegTZWExwrjgodDeNaLW0/l8MVDL8ml+LqTB
 sN/3OJXRFfDm88pt2VQCWZYUS+T9HnzceFjzOlvcBQUilIK7Z6Y3YSZO5/hU2HbRYiaj
 f/1jLfr6QoRao0VurycyAF1Hy8vL+Q6DobqCoe6azGFIgWszFK1l6PGzq914gYFciV4A
 VsVoM67gDWL5AZ/FdFc/LwlvDkL8SFtuBa9nr5awwk5aql510sQzUIEGj5Ma670FEnMx
 78behLl80xuWObnMbgRxGsjw4lF7Ylx2+6JjNbifsdMMnstBTa8FosGLmf8fZJOhu/FI
 O1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730901913; x=1731506713;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jrcpFSjgvzzujI+bhzhH1nSAHlFEG4p9iq2XiwLK0+w=;
 b=il5kH9R1em1Nvzwe/wwKovyASXOCtOgxKRv67sFNyMSOAleZDk8Md/KQngG0bOvQ7f
 sY9DGaZpMYi4hYIRxbZ2nw3Ct7b+4cBI+hOVR/wwiyZXo9MoxnVOPlG1NWkdtQDp+07J
 PnjFVCSYkgXDNGvP7kha29ESL1l/eK5qlnIAR/VoLjAhPuTmxm3yqsmnupoBg9B2Nx8k
 BCJn5NLUQO/30tZJBlvLpjK1bHlF2xGPBiIYyEpGmeXzjEuOrTr9mTziwbRdoYmoA+n6
 hMulyTWbZoR4dacI/Sdv2v4U0B1f1Keb2/2H6If6lCFBKSQ5wbwK+ZOBvahNVWudBx1x
 /dTg==
X-Gm-Message-State: AOJu0Yy26D5tk/nkJ8JnETGPpy9ERQTPkECP3O7uqsmZZ0qYJFRuG05J
 dxXED2OAP+XZHmIEgRTFZDLhukNvuFfeQ9c7i43RdO0Nhp1Dv+W113zwMUEUDA0=
X-Google-Smtp-Source: AGHT+IHSvOEQPT5g7LIGztcFnfySQgERVyUcXPV9gatTKZHARckzijIUNRB7axd2XHmum88BFCbdwA==
X-Received: by 2002:a17:90b:360a:b0:2e2:c3c7:bce8 with SMTP id
 98e67ed59e1d1-2e8f11d07f8mr19248304a91.7.1730901913286; 
 Wed, 06 Nov 2024 06:05:13 -0800 (PST)
Received: from localhost ([2405:9800:b660:1d69:184b:7485:e878:79c4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e99a5a32fcsm1492004a91.36.2024.11.06.06.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 06:05:12 -0800 (PST)
Date: Wed, 6 Nov 2024 21:05:10 +0700
From: Roman Bolshakov <roman@roolebo.dev>
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, dirty@apple.com, rbolshakov@ddn.com,
 pbonzini@redhat.com
Subject: Re: [PATCH 5/5] i386/hvf: Removes duplicate/shadowed variables in
 hvf_vcpu_exec
Message-ID: <Zyt3lt5gByKsLzsQ@roolebo.dev>
References: <20241105155800.5461-1-phil@philjordan.eu>
 <20241105155800.5461-6-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105155800.5461-6-phil@philjordan.eu>
Received-SPF: none client-ip=2607:f8b0:4864:20::533;
 envelope-from=roman@roolebo.dev; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 05, 2024 at 04:58:00PM +0100, Phil Dennis-Jordan wrote:
> Pointers to the x86 CPU state already exist at the function scope,
> no need to re-obtain them in individual exit reason cases.
> 

Reviewed-by: Roman Bolshakov <rbolshakov@ddn.com>

Regards,
Roman

