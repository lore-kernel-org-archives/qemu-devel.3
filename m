Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420CFCA5FDD
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 23:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xD9Np-0002Rw-FN; Sat, 03 Oct 2026 19:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zakinko@snowrabbit.org>)
 id 1xD9Nn-0002RO-AE
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 19:43:11 -0400
Received: from mail-pz2-x0d.google.com ([2607:f8b0:4864:3b::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zakinko@snowrabbit.org>)
 id 1xD9Nl-0003F5-5c
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 19:43:11 -0400
Received: by mail-pz2-x0d.google.com with SMTP id
 41be03b00d2f7-cca1f026cfeso124389a12.3
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2026 16:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=snowrabbit.org; s=google; t=1791070986; x=1791675786; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=M1homK3/3IwMGGQaAemgXu2vdN/F5rrrHsLLvHwqiU8=;
 b=QtXhBm8buLfJaqLBISFH5jhvw2WCzHQqkvWGlrKn15FwjsOZyvUIP5hdjMG4RCS+vp
 HffSJ74J5vR67HHotWE7uEXNNs82rK6fIly1+CZwtOuLxmr9Pgp0bOVrm5sRh4yfSbO0
 pP+jMBnRbrKDTTvRjE4HvdJJLPfu3MatpcMH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791070986; x=1791675786;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M1homK3/3IwMGGQaAemgXu2vdN/F5rrrHsLLvHwqiU8=;
 b=nBvo3KiWQ3HOMCOgGd6dhLW9p5qPLitH5Vwtl9ko96xZSeL/0BjZRj/oRsZ8t/8FU0
 dE0MfnmjXhlcVquKdK3MLsK00vRKFRYulAx0WdGGXw9vUvGssv7a9L6mn1YEldqSTl/G
 G3b6BsG/pTfUffx22/BPdtNfF2sYqBdOPfN7xC494AfRXsdUO2fVY+g0qOV2/NkOpoyd
 Qv/uqVlaxVCLpf1cjGCPUaDqPriu0tm+8XpTX8BCIo5s38el1qPhHOLhThXpfbUA67N1
 v4c0MPzcErpGQSdxFFOgCXIXhrzw5NXWwHZohDw+nS6TvNEA0EFEMSEtjWxz4/W9XIQm
 GTqg==
X-Gm-Message-State: AFq9FYI9O+oFkPVjEu8U0veWc4Tuhg8cnfiqXCwZ2c87BM/90pJD4kYt
 /dz7SXMDKKrjYwmEqnpa/B2aGcy4XOb8EMCJeI6WuR48NpEmh5My97yH8FClv3JPo5g=
X-Gm-Gg: AYBFou3uNtNxuk6jJaWMf0kjLFAcgJkp1iP1n/RCVXjtIvA8FDMSC08HdLdqJ86g6h1
 1MiL+gfMp/WuA+DX2Tvm6WoyCDfhaQ2V42mUf0rrg/LpfBYNVuUqRaFn93LWTF8PFrRF42z4xB3
 WO6tbrQgyGgPm0GMqrPqJy54GsmKSWJ9iDf4A59WBxYw16ucF73Yv1JOAHTyfJbi/tTBK+cbOJy
 88Tp3kD4jPuA/LebQuUOBYxcbPvLlK9P8w/BPQo+RYAQxm9b3KbvSDyNDzEy+K7L4Gw6N2/r2Dd
 VlUIkyw3c7NHRKLo6iQQaXtSvv7Z/Cs3naSgSqBIaBTdj3vqXsiFIqfcgf2Qupo7+xMguIIE1sz
 9vcCGSedL0Ut44ZQo6JbtxoJDLA/q86OlnvUJ56oMEKDNGS3tQfY1o6VnW6rsxDTOrp9CLjG1lD
 80+QoVgTKaJ6nzCfOnFbc5jVyOK5fNPRJqSCcOTCk4HPTCXYPOu9aO20pdUHky3pXR3rdOPQE/7
 K22Zd84iULQ/W2QEs9P/XpaLh9r4JqKbg==
X-Received: by 2002:a17:90b:4b0e:b0:39e:2f57:67c0 with SMTP id
 98e67ed59e1d1-3a6cdd9e044mr10475703a91.0.1791070986375; 
 Sat, 03 Oct 2026 16:43:06 -0700 (PDT)
Received: from smtpclient.apple ([2405:6580:8a80:2d00:a0ce:6128:34d1:550e])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a78e4a1bfesm4812028a91.12.2026.10.03.16.43.05
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 03 Oct 2026 16:43:05 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH] hw/ppc/spapr: Add the "rtas-version" property to /rtas
From: =?utf-8?B?6J+55r6k57+U5aSq?= <zakinko@snowrabbit.org>
In-Reply-To: <20260929161126.2679fec2-3f-amachhiw@linux.ibm.com>
Date: Sun, 4 Oct 2026 08:42:54 +0900
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5E17BD06-6338-41C7-BA4E-E43771862D8E@snowrabbit.org>
References: <20260929094138.16A18C92A0@bambi.snowrabbit.org>
 <20260929161126.2679fec2-3f-amachhiw@linux.ibm.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
X-Mailer: Apple Mail (2.3901.100.1.1.12)
Received-SPF: pass client-ip=2607:f8b0:4864:3b::d;
 envelope-from=zakinko@snowrabbit.org; helo=mail-pz2-x0d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Amit,

I am sorry for the slow reply.  I have just started a new job, and it
took me a while to get back to this work.

Thank you for the review, for checking it against PAPR v10.60, and for
testing it on a nestedv2 KVM guest.  Both of your suggestions make
sense; v2 below cites PAPR v10.60 first, keeps LoPAR and LoPAPR as
secondary references, and the comment on RTAS_VERSION now names PAPR
v10.60 Table 20.  There is no other change to the code.

Thanks,
Showta

-- >8 --
Subject: [PATCH v2] hw/ppc/spapr: Add the "rtas-version" property to =
/rtas

PAPR requires every property listed in its table of /rtas device tree
properties to be present before the OS is booted (R-7.2.6-3 and Table
20 in PAPR v10.60; the same requirement is in LoPAR 2.9 and LoPAPR
1.1). One of them is "rtas-version", an integer encoding of the RTAS
interface version, and PAPR says it describes version 1 of that
interface.

spapr_dt_rtas() sets "rtas-size", "rtas-error-log-max" and
"rtas-event-scan-rate" but never "rtas-version", so a client that reads
it finds no RTAS: NetBSD's RTAS driver fails to attach when the
property is absent.

Set it to 1, the version PAPR describes.

Signed-off-by: Showta Ishizaki <zakinko@snowrabbit.org>
---
v2:
- Cite PAPR v10.60 first, as the rest of the spapr code does, and keep
  LoPAR and LoPAPR as secondary references.
- The comment on RTAS_VERSION now names PAPR v10.60 Table 20.

 hw/ppc/spapr.c         | 1 +
 include/hw/ppc/spapr.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 6d99464486..8a1b5b37b6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1068,6 +1068,7 @@ static void spapr_dt_rtas(SpaprMachineState =
*spapr, void *fdt)
                           RTAS_ERROR_LOG_MAX));
     _FDT(fdt_setprop_cell(fdt, rtas, "rtas-event-scan-rate",
                           RTAS_EVENT_SCAN_RATE));
+    _FDT(fdt_setprop_cell(fdt, rtas, "rtas-version", RTAS_VERSION));
=20
     g_assert(msi_nonbroken);
     _FDT(fdt_setprop(fdt, rtas, "ibm,change-msix-capable", NULL, 0));
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 9acda15d4f..b92d25c18e 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -830,6 +830,9 @@ void spapr_load_rtas(SpaprMachineState *spapr, void =
*fdt, hwaddr addr);
=20
 #define RTAS_EVENT_SCAN_RATE    1
=20
+/* The RTAS interface version PAPR v10.60 Table 20 describes */
+#define RTAS_VERSION            1
+
 /* This helper should be used to encode interrupt specifiers when the =
related
  * "interrupt-controller" node has its "#interrupt-cells" property set =
to 2 (ie,
  * VIO devices, RTAS event sources and PHBs).


