Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4EEFB44B4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 06:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG9gP-0002MK-Ku; Fri, 24 Apr 2026 02:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wG9gO-0002MB-P7
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 02:06:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wG9gL-0004iZ-Q4
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 02:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777010788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zoWa3Azwdmkke+C73a7rGycQVFOKXBOEbN9D0SDBFh0=;
 b=ZptQ+5zPZECIboPSxdFgUi+S3gFodH3iqvJaVJY8YghwvKQHDv7wpX2g8cGQSPyArFotuG
 1noZvWo4azX3EsV1CF0Az1bbBmpJrjwYWeXPUGP59gnX6Q00xMKj+B8g1+5jFtMHsBk7f/
 bqGiEha/eo2MnqccZdsKZVLGJqTRzQU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-91tANwg8MLCzMWNk_LWUxQ-1; Fri,
 24 Apr 2026 02:06:26 -0400
X-MC-Unique: 91tANwg8MLCzMWNk_LWUxQ-1
X-Mimecast-MFC-AGG-ID: 91tANwg8MLCzMWNk_LWUxQ_1777010785
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65FC918002CC
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 06:06:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.30])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA88F180047F
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 06:06:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 523F521E6A28; Fri, 24 Apr 2026 08:06:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Elizabeth Ashurov <eashurov@redhat.com>
Cc: qemu-devel@nongnu.org,  kkostiuk@redhat.com,  berrange@redhat.com,
 yvugenfi@redhat.com
Subject: Re: [PATCH v3] qga: add security info to guest-get-osinfo
In-Reply-To: <20260414141111.2471509-1-eashurov@redhat.com> (Elizabeth
 Ashurov's message of "Tue, 14 Apr 2026 17:11:11 +0300")
References: <20260414141111.2471509-1-eashurov@redhat.com>
Date: Fri, 24 Apr 2026 08:06:22 +0200
Message-ID: <874il0yjs1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Elizabeth Ashurov <eashurov@redhat.com> writes:

> Extend guest-get-osinfo to include security features status
> (VBS, Secure Boot, TPM) in a nested 'security' field.
> OS-specific data (e.g. Windows DeviceGuard) is separated
> using a union to allow future per-OS extensions.
>
> TPM and Secure Boot information are represented as dedicated
> structs (GuestSecurityTPMInfo and GuestSecuritySecureBootInfo).
>
> The implementation queries Win32_DeviceGuard and Win32_Tpm via
> WMI, and reads UEFI variables (SecureBoot, SetupMode, AuditMode,
> DeployedMode) through GetFirmwareEnvironmentVariable().
>
> Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>

[...]

> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index c57bc9a02f..6f4b61355b 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1490,6 +1490,10 @@
>  #     * POSIX: as defined by os-release(5)
>  #     * Windows: contains string "server" or "client"
>  #
> +# @security: Security features status.  Present if any security
> +#     information (TPM, Secure Boot, etc.) could be retrieved.
> +#     Currently populated on Windows guests only (since 11.1)
> +#
>  # .. note:: On POSIX systems the fields @id, @name, @pretty-name,
>  #    @version, @version-id, @variant and @variant-id follow the
>  #    definition specified in os-release(5).  Refer to the manual page
> @@ -1508,7 +1512,8 @@
>        '*kernel-release': 'str', '*kernel-version': 'str',
>        '*machine': 'str', '*id': 'str', '*name': 'str',
>        '*pretty-name': 'str', '*version': 'str', '*version-id': 'str',
> -      '*variant': 'str', '*variant-id': 'str' } }
> +      '*variant': 'str', '*variant-id': 'str',
> +      '*security': 'GuestSecurityInfo' } }
>  
>  ##
>  # @guest-get-osinfo:
> @@ -1952,3 +1957,130 @@
>    'returns': ['GuestNetworkRoute'],
>    'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] }
>  }
> +
> +##
> +# @GuestSecurityInfoWindows:
> +#
> +# Windows-specific security features from the Win32_DeviceGuard
> +# WMI class.  All values are raw integers as provided by the
> +# Windows API.  See
> +# https://learn.microsoft.com/en-us/windows/security/hardware-security/enable-virtualization-based-protection-of-code-integrity
> +# for the meaning of each value.
> +#
> +# @vbs-status: Whether VBS is enabled and running.
> +#
> +# @available-security-properties: Relevant security properties
> +#     available for VBS and memory integrity.
> +#
> +# @code-integrity-policy-enforcement-status: Code integrity
> +#     policy enforcement status.
> +#
> +# @required-security-properties: Required security properties
> +#     to enable VBS.

What about "Security properties required to enable VBS"?

> +#
> +# @security-services-configured: Whether Credential Guard or
> +#     memory integrity is configured.
> +#
> +# @security-services-running: Whether Credential Guard or
> +#     memory integrity is running.
> +#
> +# @usr-cfg-code-integrity-policy-enforcement-status: User-mode
> +#     code integrity policy enforcement status.
> +#
> +# Since: 11.1
> +##
> +{ 'struct': 'GuestSecurityInfoWindows',
> +  'data': {
> +      '*vbs-status': 'int',
> +      '*available-security-properties': ['int'],
> +      '*code-integrity-policy-enforcement-status': 'int',
> +      '*required-security-properties': ['int'],
> +      '*security-services-configured': ['int'],
> +      '*security-services-running': ['int'],
> +      '*usr-cfg-code-integrity-policy-enforcement-status': 'int' } }
> +
> +##
> +# @GuestSecurityInfoType:
> +#
> +# Guest operating system type for security info.
> +#
> +# @windows: Microsoft Windows
> +#
> +# Since: 11.1
> +##
> +{ 'enum': 'GuestSecurityInfoType',
> +  'data': ['windows'] }
> +
> +##
> +# @GuestSecurityInfoOs:
> +#
> +# OS-specific security information.
> +#
> +# @type: guest operating system type
> +#
> +# Since: 11.1
> +##
> +{ 'union': 'GuestSecurityInfoOs',
> +  'base': { 'type': 'GuestSecurityInfoType' },
> +  'discriminator': 'type',
> +  'data': {
> +      'windows': 'GuestSecurityInfoWindows' } }
> +
> +##
> +# @GuestSecurityTPMInfo:
> +#
> +# TPM device information.  The presence of this struct indicates
> +# that a TPM device exists on the guest.
> +#
> +# @major-version: TPM specification major version (e.g. 1 or 2)
> +#
> +# Since: 11.1
> +##
> +{ 'struct': 'GuestSecurityTPMInfo',
> +  'data': {
> +      'major-version': 'int' } }
> +
> +##
> +# @GuestSecuritySecureBootInfo:
> +#
> +# UEFI Secure Boot information.  The presence of this struct
> +# indicates that the guest supports UEFI Secure Boot.
> +#
> +# @enabled: Whether Secure Boot is currently enabled
> +#
> +# @audit-mode: Whether Secure Boot is in audit mode
> +#
> +# @deployed-mode: Whether Secure Boot is in deployed mode
> +#
> +# @setup-mode: Whether Secure Boot is in setup mode
> +#
> +# Since: 11.1
> +##
> +{ 'struct': 'GuestSecuritySecureBootInfo',
> +  'data': {
> +      'enabled': 'bool',
> +      '*audit-mode': 'bool',
> +      '*deployed-mode': 'bool',
> +      '*setup-mode': 'bool' } }
> +
> +##
> +# @GuestSecurityInfo:
> +#
> +# Guest security features status.  Fields are optional; a missing
> +# field means the information is not available on this guest OS.
> +#
> +# @tpm: TPM device information.  Absent if no TPM is present
> +#     or the information is unavailable.
> +#
> +# @secure-boot: UEFI Secure Boot information.  Absent on
> +#     legacy BIOS systems or if unavailable.
> +#
> +# @os: OS-specific security information
> +#
> +# Since: 11.1
> +##
> +{ 'struct': 'GuestSecurityInfo',
> +  'data': {
> +      '*tpm': 'GuestSecurityTPMInfo',
> +      '*secure-boot': 'GuestSecuritySecureBootInfo',
> +      '*os': 'GuestSecurityInfoOs' } }

No real issues, just a doc phrasing suggestion.  Thus, QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


