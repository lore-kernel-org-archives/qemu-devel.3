Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FC4C9833F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB8Nt-00085j-VA; Mon, 28 Sep 2026 06:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xB8Nq-00083G-4B
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:14:54 -0400
Received: from mail-yx2-x0d.google.com ([2607:f8b0:4864:41::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xB8No-0001ht-Ct
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:14:53 -0400
Received: by mail-yx2-x0d.google.com with SMTP id
 956f58d0204a3-67408b109e3so984106d50.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 03:14:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790590489; cv=none;
 d=google.com; s=arc-20260327;
 b=GiB3ySogS6BkpLa/27shSigd3oBkfRg3bs2pcIrYdDNdp76rg7aTe0a07FLDS1h9Xc
 eOlEnXP/AsFQwM/u+cnmQgTIZKnqPvnwcJhYaTNQngDcpYBvK1LQmkLGaICH+bt0OFIi
 FKE7ec1SSh9/3ruxkqRXbP0A1yV8+poT2Nwo2a2N5pjN9EWVXVeFjsYGAHAVRe3Sv/m8
 cr2HqyPsQMBuxVDYF+hmafImvxfVKGsX/56AClRSjXmg5WYvA2lCqJs2VCvru9hV7zIB
 xM9ISKC018Ssjssej1N/eDsBAVdVdfqz4j8PKABSUMyHgYJ8n6KyB3e4J8U0SjqauQEj
 wUaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XiBCiJHKw+C/zcKBLBy8Igxb+ylPPyXlNIB3fGbFwBI=;
 fh=apQ5YAk5rciH9kejZnfHIsveSgWLYiG5KT4x9gaYX6k=;
 b=epdO8cjAhrA73ldYdEsxyixFowZZrhG3kV3l5FR07JHuS3BYwY6bGjmYGiF4+eDf3v
 sGx/U+8Q9VfsT/9TdoaFdnjJBCRDRSh4pOSqzvqvX6pVltQEIqiz2qZF9oQ0152finlz
 6GEcrqhb9i1UDBEv5+L8V2KSjuc/SqWBJKiBfbCljPi6DgnTYbvs3fE3SzEBZu4duYt0
 t+9aCEk6cX0wAtjMXcyKUfXTeycNcTnfwyg0LjntAn4ADJBmpYprpcbB6nvg9lmHfN9h
 o3FsMweQHEnnEpi5Tyh4bTK3eFpnGEOkR8qcFv+PiGh6d75QLliVPD6uz40ozQ6VqRLO
 e8cw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790590489; x=1791195289; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XiBCiJHKw+C/zcKBLBy8Igxb+ylPPyXlNIB3fGbFwBI=;
 b=lDHqlOCTPDC0eVEOcPOqcPAXf5k3FBIXqzFEFMEft73K7dQfkZow53wBDUxQ4+j6cm
 BqFtPHBasZgqKHlUhrdVXF4Y/W0ffbY/AqLYq0KtT544unWnQxPNgOHw5OJ2iXdOAQOR
 QM/rBWiD+zpUoHgRMqtCWI4XMI+w+6OIzYzPUeWL0sRiuxQ1KIcxgCG08gRdJUVn4eia
 bI+yYXD3SEx/bXfKVz/ko04uz8DFwvyKWTExANp6Gl6F5c6AJ+s27Awv5tWBRSLPQj4M
 Ew3NJp2iCL2ncJSJNLhylZML6qS9pjxyEoUOVvMOsdsoPjH3KEIBlGNeP+ik/ugHhK3k
 CH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790590489; x=1791195289;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XiBCiJHKw+C/zcKBLBy8Igxb+ylPPyXlNIB3fGbFwBI=;
 b=Z8dy0uJZS5i+dUVpAYFXEg74FFaaUhjkbLdNjJwPZsrKjRZn77PkghLJE+kE1rouwM
 pAx3ar+Igj1Pogtw6LPIZFCgr+/EBndoCTtz5DVjwQiVE34uQUlnu+WTZ4H49m0eTfna
 UYeEI+srQyAdyPBcGsJJmL/SPsHUupo3/WKKrOhT4meLdGP0zIiCpZYMlPeRlP8diZOM
 6owhCav7n9yOWDAdXSSJZQYR71nVuZgTDhIpdXPE/j95SoR0pg/I/2S/cfvtn0DXAZ4K
 6dn/PIgVFuVyIQvH+DD5Wmr8TMan7VrI8ndhQsNQkW5jm0sNQ8+WxdYmTWwBzhB79CKy
 C0yw==
X-Gm-Message-State: AFq9FYIJgwjVBEvdWaoT9ggjU/fFeBwgFaJFbWl3ggF66M7JG83KYfc6
 30IlniKBK4sTktHU0tuzI7JdFc9xB1SMUHnH6mr97B9He1oYBP8iBCW/jmFHNYcE5l0NkGvcI/k
 JE0Q7OHdgczA4ljZ9JloAhav6szZ4i6h6mipwa6Ck5g==
X-Gm-Gg: AYBFou36rHMzPUPiuPVQ0rasDUvU37QGuRBcfGVYAHtL853lTq0qxzb4WgxGjunoXuo
 8/5QKFXVrddYFPEaLnBypUUmY/0y3dOrHDRJEvFTxCto4OowFVF8Hy2B64H6CfMLKGdIb7aiEIR
 Ehu38cS7f4oqb5nXeprabyaSNbdLr2efqIIIznLLCF7ZZtk8eVKlvbrJq8aLphEcMx0lfYfajU6
 EmxAd9yJ77B1hU86k2/SsNq1OaAAPs1Ezrv4knb1RW+DYN0b7AaEhlNNe/qHnK17s4pHZzTD9rd
 NxTPB/d1ydtf4XoxOL3xHtTdnnT9uh2RHcG/V2VJYeuS6RvnfthWUBWt18uB4OVkvIRzjWm/W5+
 Os/IDT98VCqzfo9BHK2z+nHZnxu0pc331GNX4zJQ=
X-Received: by 2002:a05:690e:1243:b0:675:3b2f:14a9 with SMTP id
 956f58d0204a3-6753b2f7644mr1742729d50.34.1790590488991; Mon, 28 Sep 2026
 03:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260923153516.3615007-1-brian.cain@oss.qualcomm.com>
 <20260923153516.3615007-5-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260923153516.3615007-5-brian.cain@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2026 11:14:37 +0100
X-Gm-Features: AclHuK9Hp8NkzY31hlmZ3nSb19aofD3Ux2X8dEE15uLUUfzDjmmCI8i3UHy9NcA
Message-ID: <CAFEAcA9tY8in5QSuwbqxAyUxYySBWDVWdhJmCswt=zoR33ne9Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] target/hexagon: add directory semihosting
 operations
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 23 Sept 2026 at 16:35, Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
>
> Bare-metal Hexagon programs use OPENDIR, READDIR, and CLOSEDIR
> semihosting calls to enumerate host directories. Directory handles are shared
> by CPUs in a cluster, allowing guest indices to resolve across calls.
>
> Use lock_user_string()/unlock_user() to read the OPENDIR path from guest
> memory instead of copying it into a fixed-size buffer.
>
> CLOSEDIR clears its slot in the directory list, so a stale index reports
> EBADF instead of dereferencing a freed pointer.
>
> Also add a functional test for the new semihosting operations.
>
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/hw/hexagon/hexagon.h              |  14 ++-
>  hw/hexagon/hex-subsys.c                   |  32 ++++---
>  target/hexagon/hexswi.c                   | 108 ++++++++++++++++++++++
>  tests/functional/hexagon/test_systests.py |  11 +++
>  4 files changed, 153 insertions(+), 12 deletions(-)
>
> diff --git a/include/hw/hexagon/hexagon.h b/include/hw/hexagon/hexagon.h
> index 62398eeb359..58bdcabe87e 100644
> --- a/include/hw/hexagon/hexagon.h
> +++ b/include/hw/hexagon/hexagon.h
> @@ -11,6 +11,7 @@
>
>  #include "system/memory.h"
>  #include "hw/core/boards.h"
> +#include "hw/cpu/cluster.h"
>
>  struct hexagon_board_boot_info {
>      uint64_t ram_size;
> @@ -159,6 +160,17 @@ struct hexagon_machine_config {
>      union hexagon_config_table cfgtable;
>  };
>
> +#define TYPE_HEXAGON_CLUSTER_STATE "hexagon-cluster-state"
> +OBJECT_DECLARE_SIMPLE_TYPE(HexagonClusterState, HEXAGON_CLUSTER_STATE)
> +
> +struct HexagonClusterState {
> +    CPUClusterState parent_obj;
> +
> +    struct {
> +        GList *dir_list;
> +    } semihosting;
> +};

I still don't think we should be holding this semihosting
specific information in a struct in the hardware-emulation
side of the code. File descriptors aren't per-cluster, they're
shared across all of QEMU (i.e. you can open a file in
one cluster and read it from another), so opendir handles also
should have the same semantics. That also means the code for
them can be in the semihosting related files, and not spill
out into the hardawre-emulation files.

Compare semihosting/guestfd.c, where we handle filedescriptors
for the guest by tracking them in a file-scoped global variable.

-- PMM

