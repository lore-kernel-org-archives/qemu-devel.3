Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BB8606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 06:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pond.sub.org header.i=@pond.sub.org header.a=rsa-sha256 header.s=mail header.b=JUr4a+uw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTD1f-0002JQ-T8; Tue, 17 Nov 2026 01:50:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xTD1e-0002J9-G0
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 01:50:42 -0500
Received: from oxygen.pond.sub.org ([94.130.129.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xTD1c-0006YK-8H
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 01:50:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pond.sub.org; s=mail;
 t=1794898230; bh=XJC9aN06pXZHY+1Zy2nvjAONrCdTdm29+uvOJHKYBTY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=JUr4a+uwvhsT/+zvdiv7s3JsY46+SnqGt9SeSgvcYW1iSbOONo/cyAG3BZJba2DjY
 Y16Eb6ewFLb6LcL6ETsus0nCVkgYZyYiKi4r79TxCc0MoTZ2fmJlJDaVwuTkYT/hFV
 kVK4E1Ue2a7n4WGjW2NNu/BHS8bvPqzp39D2ACsk=
Received: from blackfin.pond.sub.org (p4fd045cf.dip0.t-ipconnect.de
 [79.208.69.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id AF15B2061D;
 Tue, 17 Nov 2026 07:50:30 +0100 (CET)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D89DB21E6A04; Tue, 17 Nov 2026 07:50:34 +0100 (CET)
From: Markus Armbruster <armbru@pond.sub.org>
To: Elizabeth Ashurov <eashurov@redhat.com>
Cc: qemu-devel@nongnu.org,  kkostiuk@redhat.com,  michael.roth@amd.com,
 dholler@redhat.com,  armbru@redhat.com,  fdeutsch@redhat.com,
 yvugenfi@redhat.com,  kramdoss@redhat.com
Subject: Re: [PATCH v3 1/2] qga: Add guest-get-driver-packages command for
 Windows
In-Reply-To: <20261116161608.1145725-2-eashurov@redhat.com> (Elizabeth
 Ashurov's message of "Mon, 16 Nov 2026 18:16:07 +0200")
References: <20261116161608.1145725-1-eashurov@redhat.com>
 <20261116161608.1145725-2-eashurov@redhat.com>
Date: Tue, 17 Nov 2026 07:50:34 +0100
Message-ID: <87eccklznp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=94.130.129.15; envelope-from=armbru@pond.sub.org;
 helo=oxygen.pond.sub.org
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Elizabeth Ashurov <eashurov@redhat.com> writes:

> Add a new guest-get-driver-packages command that returns out-of-box
> driver packages from the Windows Driver Store, enumerated via the
> DISM API (DismGetDrivers).  Each entry includes the published INF
> name, original INF name, version, and provider.
>
> Load DismApi.dll dynamically with LoadLibraryExW so that its absence
> does not prevent qemu-ga from starting.  Initialize DISM lazily once
> per QGA process and open a separate online DISM session for each
> command invocation, with process cleanup registered through
> ga_command_state_add.
>
> Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>

[...]

> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 8cd0ba048b..081c99bc74 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1590,6 +1590,37 @@
>    'returns': ['GuestDeviceInfo'],
>    'if': 'CONFIG_WIN32' }
>  
> +##
> +# @GuestDriverPackage:
> +#
> +# An out-of-box driver package installed in the guest.

Excuse my ignorance: what's an "out-of-box driver package"?  Is this
established Windows terminology, or something you made up?

Please use the revised syntax for introductions:

   ##
   # @GuestDriverPackage:
   #     An out-of-box driver package installed in the guest.

Same below.

> +#
> +# @name: published INF name
> +#
> +# @original-name: base name of the original INF file
> +#
> +# @version: four-part version from the package INF DriverVer entry
> +#
> +# @vendor: package provider from the INF metadata
> +#
> +# Since: 11.2

12.0

Same below.

> +##
> +{ 'struct': 'GuestDriverPackage',
> +  'data': { 'name': 'str', '*original-name': 'str', 'version': 'str',
> +            '*vendor': 'str' },
> +  'if': 'CONFIG_WIN32' }
> +
> +##
> +# @guest-get-driver-packages:
> +#
> +# Retrieve out-of-box driver packages installed in the guest.
> +#
> +# Since: 11.2
> +##
> +{ 'command': 'guest-get-driver-packages',
> +  'returns': ['GuestDriverPackage'],
> +  'if': 'CONFIG_WIN32' }
> +
>  ##
>  # @GuestAuthorizedKeys:
>  #

