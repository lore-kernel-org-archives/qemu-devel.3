Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A060C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 08:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfc8c-0003L6-FM; Thu, 29 Feb 2024 03:51:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfc8b-0003Kw-4z
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 03:51:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfc8Z-0000V0-Bu
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 03:51:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709196690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zyg6CutsuLQmtFSTU/FvNmgrRpHcjvx7pf+fPUH+dPY=;
 b=URgn+RvKvDtjnHYTDSVUlv+jJu6qLH6m2dsYUyO769k33onJMCnyvyXZGtsQOK0Wogqzv+
 cXgA/psIMo6czkmfGT6SssaIYpF9cgq9jQoDvfVFAJX/bRGSw4wfVMlnQg45DqVeFCWpeZ
 XCqnRs3S40bbdzEQHEfiPaA6f5T/4nI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-HPgFOnXVM_WFkxdbxaey9g-1; Thu, 29 Feb 2024 03:51:24 -0500
X-MC-Unique: HPgFOnXVM_WFkxdbxaey9g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1B1A863066;
 Thu, 29 Feb 2024 08:51:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 75B8D1C060AF;
 Thu, 29 Feb 2024 08:51:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4B20C21E6740; Thu, 29 Feb 2024 09:51:22 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  David Hildenbrand
 <david@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Yanan Wang
 <wangyanan55@huawei.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Ani Sinha
 <anisinha@redhat.com>,  Peter Xu <peterx@redhat.com>,  Cornelia Huck
 <cohuck@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eric
 Blake <eblake@redhat.com>,  Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org,  qemu-devel@nongnu.org,  Michael Roth
 <michael.roth@amd.com>,  Claudio Fontana <cfontana@suse.de>,  Gerd
 Hoffmann <kraxel@redhat.com>,  Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>
Subject: Re: [PATCH v5 52/65] i386/tdx: Wire TDX_REPORT_FATAL_ERROR with
 GuestPanic facility
In-Reply-To: <20240229063726.610065-53-xiaoyao.li@intel.com> (Xiaoyao Li's
 message of "Thu, 29 Feb 2024 01:37:13 -0500")
References: <20240229063726.610065-1-xiaoyao.li@intel.com>
 <20240229063726.610065-53-xiaoyao.li@intel.com>
Date: Thu, 29 Feb 2024 09:51:22 +0100
Message-ID: <874jdr1wmt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> Integrate TDX's TDX_REPORT_FATAL_ERROR into QEMU GuestPanic facility
>
> Originated-from: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> Changes in v5:
> - mention additional error information in gpa when it presents;
> - refine the documentation; (Markus)
>
> Changes in v4:
> - refine the documentation; (Markus)
>
> Changes in v3:
> - Add docmentation of new type and struct; (Daniel)
> - refine the error message handling; (Daniel)
> ---
>  qapi/run-state.json   | 31 +++++++++++++++++++++--
>  system/runstate.c     | 58 +++++++++++++++++++++++++++++++++++++++++++
>  target/i386/kvm/tdx.c | 24 +++++++++++++++++-
>  3 files changed, 110 insertions(+), 3 deletions(-)
>
> diff --git a/qapi/run-state.json b/qapi/run-state.json
> index dd0770b379e5..b71dd1884eb6 100644
> --- a/qapi/run-state.json
> +++ b/qapi/run-state.json
> @@ -483,10 +483,12 @@
>  #
>  # @s390: s390 guest panic information type (Since: 2.12)
>  #
> +# @tdx: tdx guest panic information type (Since: 9.0)
> +#
>  # Since: 2.9
>  ##
>  { 'enum': 'GuestPanicInformationType',
> -  'data': [ 'hyper-v', 's390' ] }
> +  'data': [ 'hyper-v', 's390', 'tdx' ] }
>=20=20
>  ##
>  # @GuestPanicInformation:
> @@ -501,7 +503,8 @@
>   'base': {'type': 'GuestPanicInformationType'},
>   'discriminator': 'type',
>   'data': {'hyper-v': 'GuestPanicInformationHyperV',
> -          's390': 'GuestPanicInformationS390'}}
> +          's390': 'GuestPanicInformationS390',
> +          'tdx' : 'GuestPanicInformationTdx'}}
>=20=20
>  ##
>  # @GuestPanicInformationHyperV:
> @@ -564,6 +567,30 @@
>            'psw-addr': 'uint64',
>            'reason': 'S390CrashReason'}}
>=20=20
> +##
> +# @GuestPanicInformationTdx:
> +#
> +# TDX Guest panic information specific to TDX, as specified in the
> +# "Guest-Hypervisor Communication Interface (GHCI) Specification",
> +# section TDG.VP.VMCALL<ReportFatalError>.
> +#
> +# @error-code: TD-specific error code
> +#
> +# @message: Human-readable error message provided by the guest. Not
> +#     to be trusted.
> +#
> +# @gpa: guest-physical address of a page that contains more verbose
> +#     error information, as zero-terminated string.  Present when the
> +#     "GPA valid" bit (bit 63) is set in @error-code.

Uh, peeking at GHCI Spec section 3.4 TDG.VP.VMCALL<ReportFatalError>, I
see operand R12 consists of

    bits    name                        description
    31:0    TD-specific error code      TD-specific error code
                                        Panic =E2=80=93 0x0.
                                        Values =E2=80=93 0x1 to 0xFFFFFFFF
                                        reserved.
    62:32   TD-specific extended        TD-specific extended error code.
            error code                  TD software defined.
    63      GPA Valid                   Set if the TD specified additional
                                        information in the GPA parameter
                                        (R13).

Is @error-code all of R12, or just bits 31:0?

If it's all of R12, description of @error-code as "TD-specific error
code" is misleading.

If it's just bits 31:0, then 'Present when the "GPA valid" bit (bit 63)
is set in @error-code' is wrong.  Could go with 'Only present when the
guest provides this information'.

> +#
> +#

Drop one of these two lines, please.

> +# Since: 9.0
> +##
> +{'struct': 'GuestPanicInformationTdx',
> + 'data': {'error-code': 'uint64',
> +          'message': 'str',
> +          '*gpa': 'uint64'}}
> +
>  ##
>  # @MEMORY_FAILURE:
>  #


