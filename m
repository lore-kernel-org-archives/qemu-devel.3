Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734E2606A324
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UTPcK0av
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLgS9-0003qx-Va; Tue, 27 Oct 2026 08:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xLgS6-0003qi-V0
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 08:38:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xLgS2-0002st-Ud
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 08:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793104729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=udJbU2Hpo9qwTP5rf1YrxfkP/23LuVPoAIFDX1mGMf0=;
 b=UTPcK0avT3kaNYhT8cYRmGtigH/38QiLuGWUADSC9x8aTxIw6lLN4IsJ14FldCCQUVa/YO
 pWZmC11MQOZ1kYUquTgWLnSRUL8Ksawe6DyU4627oNmVbVcQ8THKq5PjWg0J3g8BAEpKc/
 gzBwcvzr/kIOJRD2812RbYamLMCQWog=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-HlVed6YZNKWy_KoH2rLFiw-1; Tue,
 27 Oct 2026 08:38:45 -0400
X-MC-Unique: HlVed6YZNKWy_KoH2rLFiw-1
X-Mimecast-MFC-AGG-ID: HlVed6YZNKWy_KoH2rLFiw_1793104724
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 522A51955BD4; Tue, 27 Oct 2026 12:38:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9AAF07C6; Tue, 27 Oct 2026 12:38:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 559C021E6A04; Tue, 27 Oct 2026 13:38:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: <qemu-devel@nongnu.org>,  <pbonzini@redhat.com>,  <berrange@redhat.com>,
 <eduardo@habkost.net>,  <thomas.lendacky@amd.com>,  <huibo.wang@amd.com>
Subject: Re: [PATCH v3 3/3] i386/sev: Add KVM_EXIT_SNP_REQ_CERTS support for
 certificate-fetching
In-Reply-To: <20261026172300.2061829-4-michael.roth@amd.com> (Michael Roth's
 message of "Mon, 26 Oct 2026 12:21:49 -0500")
References: <20261026172300.2061829-1-michael.roth@amd.com>
 <20261026172300.2061829-4-michael.roth@amd.com>
Date: Tue, 27 Oct 2026 13:38:41 +0100
Message-ID: <87pkwv71ym.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Michael Roth <michael.roth@amd.com> writes:

> The GHCB specification[1] defines a VMGEXIT-based Guest Request
> hypercall to allow an SNP guest to issue encrypted requests directly to
> SNP firmware to do things like query the attestation report for the
> guest. These are generally handled purely in the kernel.
>
> In some cases, it's useful for the host to be able to additionally
> supply the certificate chain for the signing key that SNP firmware uses
> to sign these attestation reports. To allow for this, the GHCB
> specification defines an Extended Guest Request where this certificate
> data can be provided in a special format described in the GHCB spec.
> This certificate data may be global or guest-specific depending on how
> the guest was configured. Rather than providing interfaces to manage
> these within the kernel, KVM provides a new KVM_EXIT_SNP_REQ_CERTS exit
> to request the certificate contents from userspace. Implement support
> for that in QEMU.
>
> To synchronize delivery of the certificates to the guest in a way where
> they will not be rendered invalid by updates to SNP firmware or
> attestation singing/endorsement keys by management tools outside the
> purview of QEMU, it is expected by users of KVM_EXIT_SNP_REQ_CERTS to
> obtain a shared/read lock on the certificate file prior to delivering
> them back to KVM. Only after this will the attestation report be
> retrieved from firmware and bundled with the certificate data, so QEMU
> must continue to hold the file lock until KVM confirms that the
> attestation report has been retrieved/bundled.
>
> This confirmation is done by way of the kvm_immediate_exit callback
> infrastructure that was introduced in a prior commit. Once the callback
> is issued (after the next KVM_RUN), the attestation report will have
> been fetched, so the report and certificate data fetched by QEMU should
> be consistent with one another, and the certificate lock can then be
> released. The included documentation updates have more details on how
> this is handled.
>
> [1] "Guest Hypervisor Communication Block (GHCB) Standardization",
>     https://www.amd.com/en/developer/sev.html
>
> Co-developed-by: Melody Wang <huibo.wang@amd.com>
> Signed-off-by: Melody Wang <huibo.wang@amd.com>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>  docs/system/i386/amd-memory-encryption.rst |  77 +++++
>  qapi/qom.json                              |  23 +-
>  target/i386/kvm/kvm.c                      |  10 +
>  target/i386/sev-system-stub.c              |   5 +
>  target/i386/sev.c                          | 338 +++++++++++++++++++++
>  target/i386/sev.h                          |   3 +-
>  6 files changed, 454 insertions(+), 2 deletions(-)
>
> diff --git a/docs/system/i386/amd-memory-encryption.rst b/docs/system/i38=
6/amd-memory-encryption.rst
> index 6c23f3535f..da6f1a3693 100644
> --- a/docs/system/i386/amd-memory-encryption.rst
> +++ b/docs/system/i386/amd-memory-encryption.rst
> @@ -228,6 +228,83 @@ schema for the 'sev-snp-guest' object)::
>      -machine ...,confidential-guest-support=3Dsev0 \
>      -object sev-snp-guest,id=3Dsev0,cbitpos=3D51,reduced-phys-bits=3D1
>=20=20
> +Certificate-fetching (SEV-SNP)
> +------------------------------
> +
> +When an SEV-SNP guest requests an attestation report from the host, it m=
ay
> +optionally request that the host also deliver the certificates (and
> +potentially other accompanying data) as part of the response.
> +
> +QEMU can be configured to provide this certificate data in the following
> +manner::
> +
> +  # ${QEMU} \
> +    -machine ...,confidential-guest-support=3Dsev0 \
> +    -object sev-snp-guest,id=3Dsev0,cbitpos=3D51,reduced-phys-bits=3D1,c=
erts-filename=3D<certs>
> +
> +where the format of the file is defined in the SEV-ES Guest-Hypervisor
> +Communication Block Standardization (GHCB) v2.04, section 4.1.8.1, as::
> +
> +  Returned certificates are identified in a table starting at offset 0x0=
 of
> +  [the file]. Each entry consists of a 16-byte GUID, a 4-byte offset from
> +  [the file] to where the certificate data starts and a 4-byte length
> +  representing the length of the certificate data. The table is terminat=
ed
> +  with an entry containing all zeroes for the GUID, offset and length.
> +
> +  struct cert_table {
> +      struct {
> +          unsigned char guid[16];
> +          uint32 offset;
> +          uint32 length;
> +      } cert_table_entry[];
> +  };
> +
> +Because QEMU supplies the certificate to the hypervisor prior to the
> +hypervisor actually issuing an attestation request, there is potential f=
or
> +the certificate data to becoming stale due to a firmware upgrade or other
> +host management activities. The ioctl which enables certificate-fetching
> +support via the KVM hypervisor, KVM_SEV_SNP_ENABLE_REQ_CERTS, documents
> +the following suggested scheme as part of its linux documentation (v7.3
> +at the time of this writing), and it is highly recommended that all soft=
ware
> +interacting with these certificates, or performing operations that may
> +affect their validity, adopt this same scheme for interoperability::
> +
> +  The recommended scheme to do this is to use file locking (e.g. via
> +  fcntl()'s F_OFD_SETLK) in the following manner:
> +
> +    - Prior to obtaining/providing certificate data as part of servicing=
 an
> +      exit type of ``KVM_EXIT_SNP_REQ_CERTS``, the VMM should obtain a
> +      shared/read or exclusive/write lock on the certificate blob file b=
efore
> +      reading it and returning it to KVM, and continue to hold the lock =
until
> +      the attestation request is actually sent to firmware. To facilitate
> +      this, the VMM can set the ``immediate_exit`` flag of kvm_run just =
after
> +      supplying the certificate data, and just before resuming the vCPU.
> +      This will ensure the vCPU will exit again to userspace with ``-EIN=
TR``
> +      after it finishes fetching the attestation request from firmware, =
at
> +      which point the VMM can safely drop the file lock.
> +
> +    - Tools/libraries that perform updates to SNP firmware TCB values or
> +      endorsement keys (e.g. via /dev/sev interfaces such as ``SNP_COMMI=
T``,
> +      ``SNP_SET_CONFIG``, or ``SNP_VLEK_LOAD``, see
> +      Documentation/virt/coco/sev-guest.rst for more details) in such a =
way
> +      that the certificate blob needs to be updated, should similarly ta=
ke an
> +      exclusive lock on the certificate blob for the duration of any upd=
ates
> +      to endorsement keys or the certificate blob contents to ensure that
> +      VMMs using the above scheme will not return certificate blob data =
that
> +      is out of sync with the endorsement key used by firmware at the ti=
me
> +      the attestation request is actually issued.
> +
> +  This scheme is recommended so that tools can use a fairly generic/natu=
ral
> +  approach to synchronizing firmware/certificate updates via file-lockin=
g,
> +  which should make it easier to maintain interoperability across
> +  tools/VMMs/vendors.
> +
> +As such, QEMU implements this same scheme by waiting for a read-lock on =
the
> +file containing the certificate data before supplying any data it contai=
ns.
> +In order to ensure that the lock is not released until after the hypervi=
sor
> +is finished fetching the attestation report for the guest, the lock is h=
eld
> +until a subsequent exit from the hypervisor that indicates the attestati=
on
> +report has already been fetched, as which point QEMU will drop the lock.
>=20=20
>  Debugging
>  ---------
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 4810d53e58..8884a1eb66 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1104,6 +1104,25 @@
>  # @tsc-frequency: set secure TSC frequency.  Only valid if Secure TSC
>  #     is enabled (default: zero) (since 11.1)
>  #
> +# @certs-filename: Certificate data that can be passed to guests as
> +#     part of an attestion request.  See the
> +#     :doc:`/system/i386/amd-memory-encryption` documentation for more
> +#     details on the usage and file format.
> +#     (default: none) (since: 11.2)
> +#
> +# @certs-timeout: Maximum time in milliseconds to wait to obtain a
> +#     read lock on the certificate file specified by @certs-filename.
> +#     This is not a cumulative value and only affects how long QEMU
> +#     waits before returning execution to the vCPU and informing the
> +#     guest of the timeout, so the guest can still continue retrying
> +#     for as long as it likes, which for linux guests at the time of
> +#     this writing will be about 60 seconds before the guest gives
> +#     up and disables further requests.  If this guest-side timeout is
> +#     insufficient, set this higher to allow more time to fetch the
> +#     certificate.  If the guest-side timeout is sufficient,
> +#     set this lower to reduce the likelihood of soft lockups in the
> +#     guest.  (default: 100) (since: 11.2)
> +#
>  # Since: 9.1
>  ##
>  { 'struct': 'SevSnpGuestProperties',
> @@ -1117,7 +1136,9 @@
>              '*host-data': 'str',
>              '*vcek-disabled': 'bool',
>              '*secure-tsc': 'bool',
> -            '*tsc-frequency': 'uint32' } }
> +            '*tsc-frequency': 'uint32',
> +            '*certs-filename': 'str',
> +            '*certs-timeout': 'uint32' } }

Why uint32 for time?  We commonly use 'int'.

Hmm, see [*] below.

>=20=20
>  ##
>  # @TdxGuestProperties:
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index da922f72d7..9f7bdf9618 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -6651,6 +6651,16 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_=
run *run)
>              break;
>          }
>          ret =3D 0;
> +        break;
> +    case KVM_EXIT_SNP_REQ_CERTS:
> +        if (!sev_snp_enabled()) {
> +            error_report("KVM: Encountered a certificate request exit fo=
r a "
> +                         "non-SEV-SNP guest.");
> +            ret =3D -1;
> +        } else {
> +            ret =3D kvm_handle_snp_req_certs(cs, run);
> +        }
> +
>          break;
>      default:
>          fprintf(stderr, "KVM: unknown exit reason %d\n", run->exit_reaso=
n);
> diff --git a/target/i386/sev-system-stub.c b/target/i386/sev-system-stub.c
> index d97536cca1..e53f1bbefc 100644
> --- a/target/i386/sev-system-stub.c
> +++ b/target/i386/sev-system-stub.c
> @@ -34,3 +34,8 @@ int sev_es_save_reset_vector(void *flash_ptr, uint64_t =
flash_size)
>  void pc_system_parse_sev_metadata(uint8_t *flash_ptr, size_t flash_size)
>  {
>  }
> +
> +int kvm_handle_snp_req_certs(CPUState *cpu, struct kvm_run *run)
> +{
> +    g_assert_not_reached();
> +}
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 11072b00dc..3cb2e9cd0c 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -186,6 +186,8 @@ struct SevSnpGuestState {
>      uint8_t *id_auth;
>      char *host_data;
>      uint32_t tsc_khz;
> +    char *certs_filename;
> +    uint32_t certs_timeout;
>=20=20
>      struct kvm_sev_snp_launch_start kvm_start_conf;
>      struct kvm_sev_snp_launch_finish kvm_finish_conf;
> @@ -1701,6 +1703,278 @@ sev_snp_launch_finish(SevCommonState *sev_common)
>      sev_set_guest_state(sev_common, SEV_STATE_RUNNING);
>  }
>=20=20
> +/*
> + * Cases where -EAGAIN is returned on an error path are expected to term=
inate
> + * after the next call (e.g. via a qemu_open() error) if they are not tr=
ansient
> + * issues. These potentially-transient issues are still logged however, =
since
> + * they are not expected on a well-behaved system.
> + */
> +static int open_certs_locked(SevSnpGuestState *sev_snp_guest)
> +{
> +    struct stat locked_file, current_file;
> +    int fd, ret;
> +
> +    fd =3D qemu_open(sev_snp_guest->certs_filename, O_RDONLY, NULL);
> +    if (fd =3D=3D -1) {
> +        error_report_once("Unable to open certificate file: %s",
> +                          strerror(errno));
> +        return -errno;
> +    }
> +
> +    if (fstat(fd, &locked_file) =3D=3D -1) {
> +        error_report_once("Unable to check status of certificate file: %=
s",
> +                          strerror(errno));
> +        ret =3D -errno;
> +        goto out_close;
> +    }
> +
> +    ret =3D qemu_lock_fd(fd, 0, 0, false);
> +    if (ret =3D=3D -EACCES) {
> +        /*
> +         * F_SETLK is documented to potentially return either EACCES or =
EAGAIN
> +         * for contended file locks.
> +         */
> +        ret =3D -EAGAIN;
> +    } else if (ret =3D=3D -EDEADLK) {
> +        error_report_once("Potential deadlock encountered while trying "
> +                          "to lock the certificate file");
> +        ret =3D -EAGAIN;
> +    }
> +
> +    if (ret) {
> +        if (ret !=3D -EAGAIN) {
> +            error_report_once("Error while trying to lock certificate fi=
le: %s",
> +                              strerror(-ret));
> +        }
> +        goto out_close;
> +    }
> +
> +    if (stat(sev_snp_guest->certs_filename, &current_file) =3D=3D -1) {
> +        error_report_once("Certificate file no longer present: %s",
> +                          strerror(errno));
> +        ret =3D -EAGAIN;
> +        goto out_close;
> +    }
> +
> +    /*
> +     * Locked files should not be changing; this violates the locking
> +     * protocol assumed by this implementation. Indicate the need to
> +     * retry to the caller, but make sure to log it first.
> +     */
> +    if (locked_file.st_ino !=3D current_file.st_ino ||
> +        locked_file.st_dev !=3D current_file.st_dev) {
> +        error_report_once("Locked certificate file was recreated");
> +        ret =3D -EAGAIN;
> +        goto out_close;
> +    }
> +
> +    /*
> +     * The locked file is intact and as-expected, and it has not been re=
placed
> +     * since then, so the fd should be okay to use.
> +     */
> +    return fd;
> +
> +out_close:
> +    close(fd);
> +    return ret;
> +}
> +
> +static void close_certs(int fd)
> +{
> +    qemu_unlock_fd(fd, 0, 0);
> +    close(fd);
> +}
> +
> +static ssize_t get_certs_size(int fd)
> +{
> +    ssize_t size;
> +
> +    size =3D lseek(fd, 0, SEEK_END);
> +    if (size =3D=3D -1) {
> +        error_report_once("Error while determining the size of the certi=
ficate file: %s",
> +                          strerror(errno));
> +        return -errno;
> +    }
> +
> +    return size;
> +}
> +
> +static int read_certs(int fd, void *buf, size_t buf_len)
> +{
> +    ssize_t n;
> +
> +    n =3D lseek(fd, 0, SEEK_SET);
> +    if (n =3D=3D -1) {
> +        error_report_once("Error while setting certificate file position=
: %s",
> +                          strerror(errno));
> +        return -errno;
> +    }
> +
> +    while ((n =3D read(fd, buf, buf_len)) !=3D 0) {
> +        if (n =3D=3D -1) {
> +            if (errno =3D=3D EINTR) {
> +                continue;
> +            }
> +
> +            error_report_once("Error reading the certificate file: %s",
> +                              strerror(errno));
> +            return -errno;
> +        }
> +        buf +=3D n;
> +        buf_len -=3D n;
> +    }
> +
> +    return 0;
> +}
> +
> +static void snp_release_certs_lock(CPUState *cpu, run_on_cpu_data data)
> +{
> +    close_certs(data.host_int);
> +}
> +
> +/*
> + * NOTE: It is not expected that the guest will call this in a tight loop
> + * where error reporting would flood logs. A failed certificate fetch re=
sults
> + * in a failed attestation request, which results in a disabled attestat=
ion
> + * driver in the guest usually.
> + *
> + * However, one instance of such an error is usually enough of a clue to
> + * to identify the component of the system that should be investigated.
> + *
> + * So, to guard against a malicious guest trying to flood host logs, whi=
le
> + * still providing reasonable debug/error information to the user, use
> + * error_report_once() throughout this function and its supporting helpe=
rs.
> + */
> +int kvm_handle_snp_req_certs(CPUState *cpu, struct kvm_run *run)
> +{
> +    struct kvm_exit_snp_req_certs *req_certs =3D &run->snp_req_certs;
> +    SevSnpGuestState *sev_snp_guest;
> +    ssize_t certs_size;
> +    uint32_t npages;
> +    void *guest_buf;
> +    int64_t t0_ms;
> +    hwaddr buf_sz;
> +    int ret, fd;
> +    hwaddr gpa;
> +
> +    gpa =3D req_certs->gpa;
> +    npages =3D req_certs->npages;
> +
> +    sev_snp_guest =3D SEV_SNP_GUEST(MACHINE(qdev_get_machine())->cgs);
> +    if (!sev_snp_guest->certs_filename) {
> +        req_certs->ret =3D 0;
> +        return 0;
> +    }
> +
> +    /*
> +     * By default, any errors encountered below will be forwarded to the=
 guest
> +     * as an EIO. This will likely result in the guest disabling its dri=
ver, but
> +     * it's better than crashing QEMU.
> +     *
> +     * Leave the special cases, SUCCESS/ENOSPC/EAGAIN, to re-set the gue=
st
> +     * return code as-needed.
> +     *
> +     * Errors that are useful for debugging QEMU will still be logged, w=
ith care
> +     * to avoid busy/EAGAIN paths/etc.
> +     */
> +    req_certs->ret =3D EIO;
> +
> +    /*
> +     * -EAGAIN from open_certs_locked() indicates that a lock could not =
be
> +     * obtained on the certificate file. It would be possible to set
> +     * req_certs->ret =3D EAGAIN to immediately inform the requesting vC=
PU of
> +     * this condition so that it can retry again later, however, linux g=
uests
> +     * are currently hard-limited to a 60 second timeout, at which point=
 they
> +     * will assume misbehavior and refuse to continue issuing attestation
> +     * requests from that point forward.
> +     *
> +     * Avoid risking triggering this by instead busy-waiting on the QEMU=
 side,
> +     * which allows more time for QEMU to wait on potentially long-runni=
ng
> +     * tasks like SNP firmware updates/etc. which may be holding an excl=
usive
> +     * lock on the certificate file.
> +     *
> +     * The down-side to doing things this way is that too long of a busy=
-wait
> +     * will result in soft-lockups in the guest, but the guest will othe=
rwise
> +     * continue normally afterward.
> +     *
> +     * If the QEMU-side timeout is reached, then just go ahead and indic=
ate
> +     * EAGAIN to the guest, at which point the above-mentioned guest-side
> +     * timeout will trigger if QEMU's timeout exceeds that of the guest.=
 But
> +     * that's better than killing the vCPU, which is the only viable
> +     * alternative at that point.
> +     */
> +    t0_ms =3D g_get_monotonic_time() / 1000;
> +
> +    do {
> +        fd =3D open_certs_locked(sev_snp_guest);
> +
> +        if (fd =3D=3D -EAGAIN) {
> +            int64_t t1_ms =3D g_get_monotonic_time() / 1000;
> +
> +            if (t1_ms - t0_ms > sev_snp_guest->certs_timeout) {

[*] Left operand is int64_t, and the right operand is uint32_t.  The
right operand is converted to int64_t, which is safe, but to see that,
you need to know the "usual arithmetic conversions (C99 =C2=A7 6.3.1.8)
intimately.  Suggest to make the right operand int64_t to avoid such
brain burn.

> +                req_certs->ret =3D EAGAIN;
> +                return 0;
> +            }
> +
> +            /*
> +             * If some other process (QEMU only ever takes a read lock) =
has an
> +             * exclusive lock on the certificate file, then it is likely=
 because
> +             * a firmware update or other long-running operation is taki=
ng place;
> +             * it's a waste to re-try at a high rate.
> +             */
> +            g_usleep(1000);
> +        } else if (fd < 0) {
> +            return 0;
> +        }
> +    } while (fd =3D=3D -EAGAIN);
> +
> +    certs_size =3D get_certs_size(fd);
> +    if (certs_size < 0) {
> +        goto err_close;
> +    }
> +
> +    buf_sz =3D (hwaddr)npages * TARGET_PAGE_SIZE;
> +    if (buf_sz < certs_size) {
> +        /* Communicate to guest that more pages are needed. */
> +        req_certs->ret =3D ENOSPC;
> +        req_certs->npages =3D DIV_ROUND_UP(certs_size, TARGET_PAGE_SIZE);
> +        goto err_close;
> +    }
> +
> +    guest_buf =3D address_space_map(&address_space_memory, gpa, &buf_sz,=
 true,
> +                                  MEMTXATTRS_UNSPECIFIED);
> +    if (!guest_buf) {
> +        error_report_once("Unable to map guest buffer to provide "
> +                          "certificate data.");
> +        goto err_close;
> +    }
> +
> +    if (buf_sz < (hwaddr)npages * TARGET_PAGE_SIZE) {
> +        error_report_once("Unable to map the full guest buffer to provid=
e "
> +                          "certificate data.");
> +        address_space_unmap(&address_space_memory, guest_buf, buf_sz, tr=
ue, 0);
> +        goto err_close;
> +    }
> +
> +    ret =3D read_certs(fd, guest_buf, buf_sz);
> +    address_space_unmap(&address_space_memory, guest_buf, buf_sz, true, =
buf_sz);
> +
> +    if (!ret) {
> +        /*
> +         * Looks good, return the certificate to the guest and prepare to
> +         * release the file lock once KVM signals completion.
> +         */
> +        kvm_add_immediate_exit_callback(cpu, snp_release_certs_lock,
> +                                        RUN_ON_CPU_HOST_INT(fd));
> +
> +        req_certs->ret =3D 0;
> +        return 0;
> +    }
> +
> +err_close:
> +    close_certs(fd);
> +    return 0;
> +}
>=20=20
>  static void
>  sev_vm_state_change(void *opaque, bool running, RunState state)
> @@ -2051,6 +2325,41 @@ static int sev_snp_kvm_init(ConfidentialGuestSuppo=
rt *cgs, Error **errp)
>      g_free(sev_snp_guest->kernel_hashes_data);
>      sev_snp_guest->kernel_hashes_data =3D NULL;
>=20=20
> +    if (sev_snp_guest->certs_filename) {
> +        unsigned long certs_attr;
> +        struct kvm_device_attr attr =3D {
> +            .group =3D KVM_X86_GRP_SEV,
> +            .attr =3D KVM_X86_SEV_SNP_REQ_CERTS,
> +            .addr =3D (unsigned long) &certs_attr
> +        };
> +        int ret;
> +
> +        if (!kvm_check_extension(kvm_state, KVM_CAP_SYS_ATTRIBUTES) ||
> +            !kvm_check_extension(kvm_state, KVM_CAP_IMMEDIATE_EXIT)) {
> +            return -EINVAL;
> +        }
> +
> +        ret =3D kvm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr);
> +        if (ret < 0) {
> +            error_setg(errp, "Certificate-fetching attribute not present=
.");
> +            return ret;
> +        }
> +
> +        if (!certs_attr) {
> +            error_setg(errp, "Certificate-fetching attribute not set.");
> +            return -EINVAL;
> +        }
> +
> +        ret =3D sev_ioctl(SEV_COMMON(sev_snp_guest)->sev_fd,
> +                        KVM_SEV_SNP_ENABLE_REQ_CERTS,
> +                        NULL, NULL);
> +        if (ret) {
> +            error_setg(errp, "Failed to enable support for SEV-SNP "
> +                             "certificate-fetching requests.");
> +            return ret;
> +        }
> +    }
> +
>      return 0;
>  }
>=20=20
> @@ -3320,6 +3629,26 @@ sev_snp_guest_set_tsc_frequency(Object *obj, Visit=
or *v, const char *name,
>      SEV_SNP_GUEST(obj)->tsc_khz =3D value / 1000;
>  }
>=20=20
> +static char *
> +sev_snp_guest_get_certs_filename(Object *obj, Error **errp)
> +{
> +    SevSnpGuestState *sev_snp_guest =3D SEV_SNP_GUEST(obj);
> +
> +    return g_strdup(sev_snp_guest->certs_filename);
> +}
> +
> +static void
> +sev_snp_guest_set_certs_filename(Object *obj, const char *value, Error *=
*errp)
> +{
> +    SevSnpGuestState *sev_snp_guest =3D SEV_SNP_GUEST(obj);
> +
> +    if (sev_snp_guest->certs_filename) {
> +        g_free(sev_snp_guest->certs_filename);
> +    }
> +
> +    sev_snp_guest->certs_filename =3D value ? g_strdup(value) : NULL;
> +}
> +
>  static void
>  sev_snp_guest_class_init(ObjectClass *oc, const void *data)
>  {
> @@ -3361,6 +3690,12 @@ sev_snp_guest_class_init(ObjectClass *oc, const vo=
id *data)
>      object_class_property_add(oc, "tsc-frequency", "uint32",
>                                sev_snp_guest_get_tsc_frequency,
>                                sev_snp_guest_set_tsc_frequency, NULL, NUL=
L);
> +    object_class_property_add_str(oc, "certs-filename",
> +                                  sev_snp_guest_get_certs_filename,
> +                                  sev_snp_guest_set_certs_filename);
> +    object_class_property_add_uint32_ptr(oc, "certs-timeout",
> +                                   offsetof(SevSnpGuestState, certs_time=
out),
> +                                   OBJ_PROP_FLAG_READWRITE);
>  }
>=20=20
>  static void
> @@ -3374,6 +3709,8 @@ sev_snp_guest_instance_init(Object *obj)
>      /* default init/start/finish params for kvm */
>      sev_snp_guest->kvm_start_conf.policy =3D DEFAULT_SEV_SNP_POLICY;
>      sev_set_feature(SEV_COMMON(sev_snp_guest), SVM_SEV_FEAT_SNP_ACTIVE, =
true);
> +
> +    sev_snp_guest->certs_timeout =3D 100;
>  }
>=20=20
>  static void
> @@ -3387,6 +3724,7 @@ sev_snp_guest_finalize(Object *obj)
>      g_free(sev_snp_guest->id_auth_base64);
>      g_free(sev_snp_guest->id_auth);
>      g_free(sev_snp_guest->host_data);
> +    g_free(sev_snp_guest->certs_filename);
>  }
>=20=20
>  /* guest info specific to sev-snp */
> diff --git a/target/i386/sev.h b/target/i386/sev.h
> index 7725f92e19..4d9e9b44b4 100644
> --- a/target/i386/sev.h
> +++ b/target/i386/sev.h
> @@ -15,6 +15,7 @@
>  #define I386_SEV_H
>=20=20
>  #include "target/i386/svm.h"
> +#include "system/kvm.h"
>=20=20
>  #ifndef CONFIG_USER_ONLY
>  #include CONFIG_DEVICES /* CONFIG_SEV */
> @@ -198,5 +199,5 @@ void pc_system_parse_sev_metadata(uint8_t *flash_ptr,=
 size_t flash_size);
>=20=20
>  uint32_t sev_get_cbit_position(void);
>  uint32_t sev_get_reduced_phys_bits(void);
> -
> +int kvm_handle_snp_req_certs(CPUState *cpu, struct kvm_run *run);
>  #endif


