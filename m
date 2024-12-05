Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F7DE7716D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 12:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJB2Q-0003uR-9f; Thu, 05 Dec 2024 07:32:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tJB2O-0003u4-VP
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 07:32:56 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tJB2M-0008Np-TV
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 07:32:56 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385e2c52c21so680313f8f.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 04:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733401972; x=1734006772; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7QatEww3p5uincMuCHGM2HklsAUuluoA0dTIGETLpfY=;
 b=YmDL+a5zFl+QmjYN2xPBtfULl+/62BHcSjWZsiOxLSexT3+y9pqfUGdjw/eM8M0nIo
 gUzuVV7hKud7VgjKsVF9d47xPgyJM+MrrcT3M6CLnH0wj57GNkKWfIcJLJyXFmvURPiV
 BIIHk5Ct/p+zCRid7L0j2UPOu+zMW8Hhiv6LqzHkwMW5mgUdUL4pNArNYN5FHLdCyiH+
 jq7Lvkw0/ER2xLYdzVjAC77pX5ANNdtmptHpIp3xL7nZfO9Q3NNBP8NoleFpVBm8F8B6
 3eamE5zNIy2vX4pHwXSiGuRcLaGB7fh04pUCollFnuEoyhydpaiDaDdasREJjIt4F5Pd
 jAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733401972; x=1734006772;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7QatEww3p5uincMuCHGM2HklsAUuluoA0dTIGETLpfY=;
 b=bKHzzgmmnAHwkWFixNH7z67yru3LTKZC6k4K6qQTT+atCt2c6zspN5n4aFxJ2DaL/r
 eKQd1l28aSV4IzfhARnOF6HEXXnzuFEo/L++5APrj0LL2BX0UVVnrAl8sSNQQk86JDcX
 +pGFJ+t19fp9y3H1EOynUd3EEQY73mKXTwUnYlI4ChRRzLcI+R3fw0VYD8IYW4kQPyjr
 49D/8ePR0LDrL58KjLiH95N+HGCmjAwAymY9pM29zKIWzRBT5ZlKFLJb/teI2Hhiz4SI
 v8BP2nJYuKUib/hCkhPcr9UkYCsboIkakzkl7ajqkBgmSDIuNUla5TOecyBdTj46cHUO
 aZdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgwvyHRBF8LnsTwYnUxx/GyilIXOy84F93LtsDmVnFsaieWCyNEuNMOQbqvmZtbudXdql82RbQI1FD@nongnu.org
X-Gm-Message-State: AOJu0YwwS+fodEiOeEB1HWx6M6vwB6bskBRsiA8d6JDTWuRmkzvcxAvN
 1Oq7pBBNnkzU9oLBebT+VVJP0OLVcMCdacQ9FBsz+azW6f+cWQLPTPrDmPLRXVs=
X-Gm-Gg: ASbGncul5FfIth/+his9GSyiC0ky6M54rP6Xr83UiE47euGi6d65xbPxdJh7nBL1dEo
 28nyvu/dgzLghVa2U9FtKfXHTyqYqOcuzPrzAl013nAzUdKtaw7726A+BANHZhgqW8PHnzOZq9E
 fykcRS4rtTcq+Sgs9vga0FJt3UcHSumCjLpR1NKL/pwmohUr50J9kEcWBmfZn8BzDRzdWTb1WJt
 +MUjzGfqPyXNSd4uM23APLz2lH+8vyBUw3zNvSaRlrVRYXN
X-Google-Smtp-Source: AGHT+IGar0137GZGyq7fuSkakPayO2Iyooo2G413DupBnmFkgyBbqvY41v8oylXSRRfL9xdD31tQeQ==
X-Received: by 2002:a05:6000:1faa:b0:386:1c13:30d5 with SMTP id
 ffacd0b85a97d-3861c133159mr2116689f8f.7.1733401972303; 
 Thu, 05 Dec 2024 04:32:52 -0800 (PST)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434da113508sm22623965e9.35.2024.12.05.04.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 04:32:51 -0800 (PST)
Date: Thu, 5 Dec 2024 12:33:16 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 philmd@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v3 25/26] target/arm/kvm-rme: Add measurement log
Message-ID: <20241205123316.GA567753@myrica>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-27-jean-philippe@linaro.org>
 <02b90518-2996-4231-bee9-43ce313669b0@linux.ibm.com>
 <Z0XREyMovNyB4s6t@redhat.com> <20241126162149.GC956991@myrica>
 <d3d73795-3f59-490c-9e54-c6c358af62d0@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3d73795-3f59-490c-9e54-c6c358af62d0@linux.ibm.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x433.google.com
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

On Mon, Dec 02, 2024 at 10:58:01AM -0500, Stefan Berger wrote:
> 
> 
> On 11/26/24 11:21 AM, Jean-Philippe Brucker wrote:
> > On Tue, Nov 26, 2024 at 01:45:55PM +0000, Daniel P. Berrangé wrote:
> > > On Mon, Nov 25, 2024 at 05:23:44PM -0500, Stefan Berger wrote:
> > > > 
> > > > 
> > > > On 11/25/24 2:56 PM, Jean-Philippe Brucker wrote:
> > > > > Create an event log, in the format defined by Trusted Computing Group
> > > > > for TPM2. It contains information about the VMM, the Realm parameters,
> > > > > any data loaded into guest memory before boot and the initial vCPU
> > > > > state.
> > > > > 
> > > > > The guest can access this log from RAM and send it to a verifier, to
> > > > > help the verifier independently compute the Realm Initial Measurement,
> > > > > and check that the data we load into guest RAM is known-good images.
> > > > > Without this log, the verifier has to guess where everything is loaded>
> > > > and in what order.
> > > > 
> > > > Typically these logs are backed by extensions of TPM PCRs and when you send
> > > > a log to a verifier you send a TPM quote along with it for the verifer to
> > > > replay the log and check the TPM quote. Also, early code in the firmware is
> > > > typically serving as a root of trust that starts the chain of measurements
> > > > of code and data, first measuring itself and then other parts of the
> > > > firmware before it jumps into the other parts. Now here you seem to just
> > > > have a log and no PCR extensions and therefore no quote over PCRs can be
> > > > used.
> > 
> > Indeed, in our case it's the trusted hypervisor (RMM) that provides the
> > equivalent to TPM quote and PCRs. In more details:
> > 
> > 1. QEMU loads images into guest RAM by calling KVM, which calls RMM.
> > 2. RMM calculates a hash of the image content, adds it to a rolling hash
> >     the "Realm Initial Measurement" (RIM), which I believe is equivalent to
> >     a PCR.
> 
> I am not familiar with RIM. A link to read more about it would be helpful.

The "Learn the architecture" documentation might be a good introduction
https://developer.arm.com/documentation/den0127/0200/Overview
In particular the part about Realm creation:
https://developer.arm.com/documentation/den0127/0200/Realm-management/Realm-creation-and-attestation

The RMM specification describes exactly how the RIM is calculated, but
is less palatable:
https://developer.arm.com/documentation/den0137/1-0rel0/?lang=en
A7.1.1 Realm Initial Measurement

More specialized resource are the attestation token documentation:
[1] https://datatracker.ietf.org/doc/html/draft-ffm-rats-cca-token-00
and CCA Security Model:
https://developer.arm.com/documentation/DEN0096/latest/

> 
> > 3. During remote attestation, the guest sends evidence containing this RIM
> >     signed by the root of trust, along with a signed token identifying the
> >     platform (hardware, firmware, RMM).
> 
> Is this a well known manufacturer key that one would expect for signature
> verification or is it locally created?

It comes from a well known manufacturer key, although the signing can be
delegated in some models (like in the current demos):

The hardware RoT creates a key pair for the RMM, which the RMM uses to
sign the RIM. The RoT then signs the RMM pubkey, using the well-known key
(see [1] 4.10 Token Binding).

> 
> > 4. The verifier checks the signature and the platform token, so it trusts
> >     the RMM and the RIM.
> > 
> > > > Then what prevents anyone from faking this log and presenting a
> > > > completely fake log to the verifier?
> > 
> > Absolutely, the verifier does not trust the content of the log, it only
> > uses the log as helper to try to reconstruct the RIM. For example a log
> > event says "I loaded image XYZ at address A", then the verifier searches
> > image XYZ in its database of known-good images, calculates the hash that
> > would result from loading that image at address A. Any malformed event in
> 
> Hopefully just calculating a hash over the image will do and the location an
> image was loaded to, like address A (relocation?), doesn't matter...

In this case it does matter because we don't trust the host VMM which
instructs RMM where to load the images. So we need to verify that the
image is in the correct location, otherwise the VM could be executing the
wrong part of the code, or using the wrong part of the data loaded into
RAM.

When loading an image the RMM hashes its content, then hashes a structure
that contains both the content hash and the address, and it is that hash
that is added to the RIM.

Thanks,
Jean


