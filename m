Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75B6FF60C6
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 06:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7SFt-0000OS-OK; Tue, 31 Mar 2026 02:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1w7SFs-0000O6-2J
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 02:07:12 -0400
Received: from oxygen.pond.sub.org ([94.130.129.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1w7SFq-0002Xf-73
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 02:07:11 -0400
Received: from blackfin.pond.sub.org
 (p200300d36f125200d4b07119e720e6da.dip0.t-ipconnect.de
 [IPv6:2003:d3:6f12:5200:d4b0:7119:e720:e6da])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id B46DC20EC2
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 08:10:26 +0200 (CEST)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F36B421E6A28; Tue, 31 Mar 2026 08:07:04 +0200 (CEST)
To: Elizabeth Ashurov <eashurov@redhat.com>
Cc: qemu-devel@nongnu.org,  kkostiuk@redhat.com,  yvugenfi@redhat.com,
 berrange@redhat.com
Subject: Re: [PATCH v2] qga: add security info to guest-get-osinfo
In-Reply-To: <20260330151941.2207789-1-eashurov@redhat.com> (Elizabeth
 Ashurov's message of "Mon, 30 Mar 2026 18:19:41 +0300")
References: <20260330151941.2207789-1-eashurov@redhat.com>
Date: Tue, 31 Mar 2026 08:07:04 +0200
Message-ID: <87tstwwn07.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=94.130.129.15; envelope-from=armbru@pond.sub.org;
 helo=oxygen.pond.sub.org
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Markus Armbruster <armbru@redhat.com>
From:  Markus Armbruster via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Elizabeth!  You neglected to cc: me.  Recommend to use
scripts/get_maintainer.pl to find all the possibly involved maintainers,
then use common sense to trim.

Elizabeth Ashurov <eashurov@redhat.com> writes:

> Extend guest-get-osinfo to include security features status
> (VBS, Secure Boot, TPM) in a nested 'security' field.
> OS-specific data (e.g. Windows DeviceGuard) is separated
> using a union to allow future per-OS extensions.
>
> The implementation queries Win32_DeviceGuard and Win32_Tpm via
> WMI, and reads the SecureBoot UEFI variable through
> GetFirmwareEnvironmentVariable().
>
> Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>

[...]

> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index c57bc9a02f..2247f77cff 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1490,6 +1490,8 @@
>  #     * POSIX: as defined by os-release(5)
>  #     * Windows: contains string "server" or "client"
>  #
> +# @security: Security features status (since 10.3)
> +#

When is this member present?

Since 11.1.  More of the same below, not flagging it again.

>  # .. note:: On POSIX systems the fields @id, @name, @pretty-name,
>  #    @version, @version-id, @variant and @variant-id follow the
>  #    definition specified in os-release(5).  Refer to the manual page
> @@ -1508,7 +1510,8 @@
>        '*kernel-release': 'str', '*kernel-version': 'str',
>        '*machine': 'str', '*id': 'str', '*name': 'str',
>        '*pretty-name': 'str', '*version': 'str', '*version-id': 'str',
> -      '*variant': 'str', '*variant-id': 'str' } }
> +      '*variant': 'str', '*variant-id': 'str',
> +      '*security': 'GuestSecurityInfo' } }
>  
>  ##
>  # @guest-get-osinfo:
> @@ -1952,3 +1955,89 @@
>    'returns': ['GuestNetworkRoute'],
>    'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] }
>  }
> +
> +##
> +# @GuestSecurityInfoWindows:
> +#
> +# Windows-specific security features from Win32_DeviceGuard.
> +#
> +# @vbs-status: VirtualizationBasedSecurityStatus

PleaseWriteNemberDescriptionsInEnglish: words, spaces, punctuation, the
works.

> +#
> +# @available-security-properties:
> +#     AvailableSecurityProperties
> +#
> +# @code-integrity-policy-enforcement-status:
> +#     CodeIntegrityPolicyEnforcementStatus
> +#
> +# @required-security-properties: RequiredSecurityProperties
> +#
> +# @security-services-configured:
> +#     SecurityServicesConfigured
> +#
> +# @security-services-running: SecurityServicesRunning
> +#
> +# @usr-cfg-code-integrity-policy-enforcement-status:
> +#     UsermodeCodeIntegrityPolicyEnforcementStatus
> +#
> +# Since: 10.3
> +##
> +{ 'struct': 'GuestSecurityInfoWindows',
> +  'data': {
> +      '*vbs-status': 'int',
> +      '*available-security-properties': ['int'],
> +      '*code-integrity-policy-enforcement-status': 'int',
> +      '*required-security-properties': ['int'],
> +      '*security-services-configured': ['int'],
> +      '*security-services-running': ['int'],
> +      '*usr-cfg-code-integrity-policy-enforcement-status':
> +          'int' } }

Please don't break this line.

> +
> +##
> +# @GuestSecurityInfoType:
> +#
> +# Guest operating system type for security info.
> +#
> +# @windows: Microsoft Windows
> +#
> +# Since: 10.3
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
> +# Since: 10.3
> +##
> +{ 'union': 'GuestSecurityInfoOs',
> +  'base': { 'type': 'GuestSecurityInfoType' },
> +  'discriminator': 'type',
> +  'data': {
> +      'windows': 'GuestSecurityInfoWindows' } }
> +
> +##
> +# @GuestSecurityInfo:
> +#
> +# Guest security features status.  Fields are optional; a missing
> +# field means the information is not available on this platform.

What do you mean by "platform"?  Host, guest, both?

> +#
> +# @tpm-present: Whether a TPM device is present
> +#
> +# @tpm-version: TPM specification version (e.g. "2.0")
> +#
> +# @secure-boot: Whether UEFI Secure Boot is enabled
> +#
> +# @os: OS-specific security information
> +#
> +# Since: 10.3
> +##
> +{ 'struct': 'GuestSecurityInfo',
> +  'data': {
> +      '*tpm-present': 'bool',
> +      '*tpm-version': 'str',
> +      '*secure-boot': 'bool',
> +      '*os': 'GuestSecurityInfoOs' } }

