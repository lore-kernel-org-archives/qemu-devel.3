Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555B4E77182
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 14:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM6hs-0001Fw-CL; Fri, 13 Dec 2024 09:31:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tM6hf-0001EU-5F
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 09:31:41 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tM6hd-0004lE-7B
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 09:31:38 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43622354a3eso12902455e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 06:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734100294; x=1734705094; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SOecfnNs8osThljsaAKU06/9OnPYwMOWV/4Rbge39/Y=;
 b=eiSEW5RI2EQAHs6I93LXYKwbS0iaPFaeG5Xy63zI2jWMMFT3nNfir8l5Mgot38zsN8
 jp8yTQ0/E4f4BvK47iQ+meJgIYHi8G+qmX4dBE5qpgTHKecYUBlv1pDXhMjQaDBgS5sA
 xM46YF3MsNsMzjfEI9j5v3xVzfo6hp57MV2xbHmnq/CeZviN0FOkVAmX4lIHlwBB70u5
 yUlUwMcQn1R5GABgvphLw3jNRpppf/7I4ury4fnD1qH0Yp24zB3OT+opJTl0dVRZrc2I
 kjqyB+ApSKHl2ueSQHn2mO8SIe5v+BkfnRo3GIGzAb5DZcKIeisuS0Mo0TmPZyNqaVeq
 eXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734100294; x=1734705094;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SOecfnNs8osThljsaAKU06/9OnPYwMOWV/4Rbge39/Y=;
 b=Wyp+9GuY72Ij3tZyAE1O0IuUpHqeNpzX3OZh/49xUENLtyliMbWIINc1qQ8KwaZq6B
 2s1LHIL7GobP9cg6SRlJasRyUEtRJswodPI2ZdwckUrgKGWTnbFVOgbLDMBhw9H3zskS
 7JYq5iIqy6fAQBPoYZ4fedU90EHj/qa27gdzRMwAWjv542ai0JYrVW9CVcsZi0nEpQ9b
 GQvRGnTLt/MrNtCAlBDLa7indojhipJqOtXDVzf81Yrz9VIeCJKK0J7Jp0dqREux9BuM
 EXr7yqST16Z+fu3RJraV08+wL2OflXWs2Pb2pkkZ/1WVXn/8G0vD0H/C3/fEkZWGwzC5
 khcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV77s299oTmuVw8I2+ciAAF4hQlI2PXbwORKhgo4U1zn+NhfEExwF32unPV2RQWtqThQoWh5f8ob0Ol@nongnu.org
X-Gm-Message-State: AOJu0Yycy+uQScBzuUfkw7vcL4s/ueDsagPtrAGVUKwSlI7JR1zk6xAj
 UP1Axgt/2UrKSXo8ygLJEnJHMjNKPyyKqaFhupBPTArUYHMtk8PDhYL7Ud7aOvU=
X-Gm-Gg: ASbGncs5ByJEc1Ox//krJcbvnmotOS2ujLXtTgGexS7yBbcN763+b1oPkIr4/jLiPsJ
 W40ynkn8pGdNrW6S8uDNT3S8C0kV9Q+HjUntFBS26aoO714UfaMj2JHA3jFo6XtMewwSMEImQ1l
 Rlw7c89035CGTSZedtep/jHr76QuDpm/oMRFcwsOnrpI3yGAqDMZVQLN6sYEvTb7ImVu3yDpIRu
 RyH63z/gby7MYTOlT/n9VRGOjQKFatuVlFWBx89w5ToXSsmRyIh6z0=
X-Google-Smtp-Source: AGHT+IG2cHyWZGrtAijYHh0GaSeRIjMYA9G08jmCcjF2sx0R2CtD4J1Job5e8KaQZ8XAYh7s93jKdg==
X-Received: by 2002:a05:6000:1fae:b0:386:366d:5d03 with SMTP id
 ffacd0b85a97d-38880ad88dcmr2171599f8f.16.1734100294465; 
 Fri, 13 Dec 2024 06:31:34 -0800 (PST)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38782514c06sm7357538f8f.73.2024.12.13.06.31.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 06:31:34 -0800 (PST)
Date: Fri, 13 Dec 2024 14:31:58 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 philmd@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v3 23/26] hw/tpm: Add TPM event log
Message-ID: <20241213143158.GD2962236@myrica>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-25-jean-philippe@linaro.org>
 <1da8840e-a7be-48c5-bc06-e7a4e111b9e7@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1da8840e-a7be-48c5-bc06-e7a4e111b9e7@linux.ibm.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x32c.google.com
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

On Mon, Dec 09, 2024 at 05:34:13PM -0500, Stefan Berger wrote:
> 
> 
> On 11/25/24 2:56 PM, Jean-Philippe Brucker wrote:
> > Provide a library allowing the VMM to create an event log that describes
> > what is loaded into memory. During remote attestation in confidential
> > computing this helps an independent verifier reconstruct the initial
> > measurements of a VM, which contain the initial state of memory and
> > CPUs.
> > 
> > We provide some definitions and structures described by the Trusted
> > Computing Group (TCG) in "TCG PC Client Platform Firmware Profile
> > Specification" Level 00 Version 1.06 Revision 52 [1]. This is the same
> > format used by UEFI, and UEFI could reuse this log after finding it in
> 
> as used by
> 
> > DT or ACPI tables, but can also copy its content into a new one.
> 
> I thought it was going to be a completely independent log. If UEFI would do
> anything with it, I think it would have to replay the measurements into its
> own log and extend them into all PCRs of all active PCR banks of the TPM,

UEFI does need an event log, because it will measure some images using the
RMM's Realm Extensible Measurement (REM) registers, but nothing forces us
to use the same log. To reuse the existing measurement infrastructure
those REM registers can be mapped to the PCR numbers already used by
UEFI's TPM support, like Intel did for TDX:

https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#intel-trust-domain-extension

So for Arm the RIM could map to PCR[0], and the four REMs could map to
PCR[1,7], PCR[2-6] etc.

> but if I understand correctly then you do not use the TPM for this log at
> all since you have a signature over it and defined (somewhere -- where?)
> that only sha256 and sha512 are to be used for this log.

The algorithm choice matches that of RMM, which only support sha256 and
sha512 at the moment. But it's arbitrary. We could use any TCG algorithm
for the log digests.

Thanks,
Jean

