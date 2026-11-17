Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290B7606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 06:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pond.sub.org header.i=@pond.sub.org header.a=rsa-sha256 header.s=mail header.b=hcaFDB6e
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTD6d-000408-O2; Tue, 17 Nov 2026 01:55:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xTD6b-0003zh-J2
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 01:55:49 -0500
Received: from oxygen.pond.sub.org ([2a01:4f8:13b:3ad0:1::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xTD6Z-0006Cl-I6
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 01:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pond.sub.org; s=mail;
 t=1794898538; bh=M58QOrMXPqrjIdTgxrODwOcU0pmjcnqD8vSZZKzLY+0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=hcaFDB6eE5mmoeZZRs0rd08m7TxoV+nHgjqUMiiptnjo5emrMfU6RsSFfWdqkhPJ9
 P1mc9XVgVdXLV+ZYgkjm4yEAL+lOVy5G7o/G0wpHIt85PoFIpRXWnRD9f+FaJM6R5E
 IYId0mH34Ijj14ZONax57yxtH3WAtJTmFIGKahFg=
Received: from blackfin.pond.sub.org (p4fd045cf.dip0.t-ipconnect.de
 [79.208.69.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id 196612061D;
 Tue, 17 Nov 2026 07:55:38 +0100 (CET)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8BB0F21E6A04; Tue, 17 Nov 2026 07:55:43 +0100 (CET)
From: Markus Armbruster <armbru@pond.sub.org>
To: Elizabeth Ashurov <eashurov@redhat.com>
Cc: qemu-devel@nongnu.org,  kkostiuk@redhat.com,  michael.roth@amd.com,
 dholler@redhat.com,  armbru@redhat.com,  fdeutsch@redhat.com,
 yvugenfi@redhat.com,  kramdoss@redhat.com
Subject: Re: [PATCH v3 2/2] qga: Add guest-get-driver-services command for
 Windows
In-Reply-To: <20261116161608.1145725-3-eashurov@redhat.com> (Elizabeth
 Ashurov's message of "Mon, 16 Nov 2026 18:16:08 +0200")
References: <20261116161608.1145725-1-eashurov@redhat.com>
 <20261116161608.1145725-3-eashurov@redhat.com>
Date: Tue, 17 Nov 2026 07:55:43 +0100
Message-ID: <878q2slzf4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2a01:4f8:13b:3ad0:1::3;
 envelope-from=armbru@pond.sub.org; helo=oxygen.pond.sub.org
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

> Add a new guest-get-driver-services command that returns registered
> driver services from the Service Control Manager
> (EnumServicesStatusExW).  Each entry includes the service name,
> configured binary path, current SCM status, and FileVersion and
> CompanyName metadata extracted from the driver binary.
>
> Normalize driver binary paths from the service database before
> reading version resources, including SystemRoot,
> environment-variable, NT-prefix, and relative path forms.
>
> Unrecognized SCM service states are reported as "unknown" with a
> log message rather than aborting the enumeration, so that future
> Windows versions do not break the command.
>
> Link against version.dll (-lversion) for the GetFileVersionInfo
> and VerQueryValue APIs.
>
> Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>

[...]

> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 081c99bc74..913fe25924 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1590,6 +1590,33 @@
>    'returns': ['GuestDeviceInfo'],
>    'if': 'CONFIG_WIN32' }
>  
> +##
> +# @GuestDriverServiceStatus:
> +#
> +# @stopped: the service is stopped
> +#
> +# @start-pending: the service is starting
> +#
> +# @stop-pending: the service is stopping
> +#
> +# @running: the service is running
> +#
> +# @continue-pending: the service is resuming
> +#
> +# @pause-pending: the service is pausing
> +#
> +# @paused: the service is paused
> +#
> +# @unknown: SCM returned a service state not recognized by this
> +#     QGA version
> +#
> +# Since: 11.2

12.0

More of the same below.

> +##
> +{ 'enum': 'GuestDriverServiceStatus',
> +  'data': [ 'stopped', 'start-pending', 'stop-pending', 'running',
> +            'continue-pending', 'pause-pending', 'paused', 'unknown' ],
> +  'if': 'CONFIG_WIN32' }
> +
>  ##
>  # @GuestDriverPackage:
>  #
> @@ -1610,6 +1637,26 @@
>              '*vendor': 'str' },
>    'if': 'CONFIG_WIN32' }
>  
> +##
> +# @GuestDriverService:
> +#
> +# @name: service name
> +#
> +# @driver-path: driver binary path configured in the service database
> +#
> +# @version: four-part FileVersion from the driver binary
> +#
> +# @vendor: CompanyName from the driver binary

Are "FileVersion" and "CompanyName" established technical terms?

Are they necessary here, or could we simply say something like "driver
version" and "driver vendor name"?

> +#
> +# @status: current service status
> +#
> +# Since: 11.2
> +##
> +{ 'struct': 'GuestDriverService',
> +  'data': { 'name': 'str', '*driver-path': 'str', '*version': 'str',
> +            '*vendor': 'str', 'status': 'GuestDriverServiceStatus' },
> +  'if': 'CONFIG_WIN32' }
> +
>  ##
>  # @guest-get-driver-packages:
>  #
> @@ -1621,6 +1668,17 @@
>    'returns': ['GuestDriverPackage'],
>    'if': 'CONFIG_WIN32' }
>  
> +##
> +# @guest-get-driver-services:
> +#
> +# Retrieve registered driver services in the guest.

Please use the revised syntax for introductions:

   ##
   # @guest-get-driver-services:
   #     Retrieve registered driver services in the guest.

> +#
> +# Since: 11.2
> +##
> +{ 'command': 'guest-get-driver-services',
> +  'returns': ['GuestDriverService'],
> +  'if': 'CONFIG_WIN32' }
> +
>  ##
>  # @GuestAuthorizedKeys:
>  #

