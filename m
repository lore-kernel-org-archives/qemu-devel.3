Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C666EE6B43
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 17:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voPn4-0005Oa-GZ; Fri, 06 Feb 2026 12:38:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1voPn3-0005OK-E4
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:38:45 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1voPn1-00037a-8v
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:38:45 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-45f0c1f1b54so1485600b6e.1
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 09:38:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770399522; cv=none;
 d=google.com; s=arc-20240605;
 b=GXs78qpM3EFDDYKVc0QxJTgSvJaqQTPQEqwhb930ddnTicz4dDSKdnHVe3Rg4MuwLG
 VAKRU3gnyM0e6deQPaIPejeUX0ATdYIZ3f8+jj3Bze7EpsCPt4hSdwLyO/5SRLbnBO/B
 aV8S22qa3m8Qjg+rSErdYo+ziMYbid1rSWee17YAC16A3mksmdfqJnNVEFRR0T0NsEDR
 4M83T9l1PBVJZzXMMlGAmMPsNZ3OsaupS0fI3Ved66+qUs4cWmkdvB3p0eHr05tIQsZg
 1F+wcmuP3sQDksZXTmMpKI+oP6nosodcaVkqUhTMVYvpyL6yD0h6g2GRsthzUyubvzEC
 gtgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7mZe/RZhk1q9Lb2cXcCE8wPKYg02pAOk9Nk+TwX3vUY=;
 fh=9Xh+R7zIRm5O897kxCGh+dkL2L1w6BVeJfthgI/kLZI=;
 b=EDRCY9fjZGNTzX6iVb7naxJusQUiI//Q9kNAa0aFb6XS8X32B6qZo7rQbs8Oy3NAej
 J9hHASiSG+pRUuUyk52EN83gFO7R/fxURLlnJDXg6N9pKBD61B+UnHIp/bUyFe87wBDJ
 v/E2NaPfgpT/SIjaM92pxTQb5H/rKZ54MKegNluZYEL7OR3c2XtwzJhA39/R6NxNUlTn
 6Enns40CVjmLiRhMwCVRvNALMaLCEqiNWMDPTrXhNHmllXFCgrTwRSFbtarRU/30ZhPc
 3cELqp3saPZE4/9mwRHHwJXN+AFVd5voNXkl7XwXJUyZZlkewwzkMzztZQdFSRY98KTi
 DbiA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770399522; x=1771004322; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7mZe/RZhk1q9Lb2cXcCE8wPKYg02pAOk9Nk+TwX3vUY=;
 b=mj7HO/3aWi2XYgmOfQTnijDBOm0rYaI5k9pFal8Ot6SagRCf+dYeQPLHAmnrOwQ5Ch
 pLrFt07LYfsIeLMbf+sYJvjAT+7zH29CtmLQgt/m5d2XUgyPw4sLyaoSL5I0jn1Guc3Z
 AEF1vC+7zZhjUsK4IBL3s9cBSyzaRUJvnGnTNmXLb00lAMR3XZevzUEriFqQ9Layt4R7
 G92QWVdrTflJ7snaLsu1EN9wkBkPddV6gvEzu0k8VNr0r/ec4zimBTZz51aZV5QurNnX
 pKUv+t7HXdB+dRuC/Uc+c0TVF23UeUXBT4Vssfdb3BGA7MiPATILC/4atmBYNzqQ/qJg
 Zbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770399522; x=1771004322;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7mZe/RZhk1q9Lb2cXcCE8wPKYg02pAOk9Nk+TwX3vUY=;
 b=tkt7DMt0VQuDRShzdEsIH/ISSOJUcjXPCShd54VMBXY3puz1QyHLFuKnboBZaKotXN
 SD21eXxDdAAxi/wXHEg15oiMsJivb8igqQ0/SJ5n7G9viSwd7sspIdYNhE+o1zrjLgPA
 kIyCjqkTC7P1PyTwI9vMYZqkGLuwInz6/X22i6U2SC930e4h5rkMNGYtrOy2cPR6+Vt+
 bk5m9XVUYEKQFBc5yJCd+9Lw60uSK64Kk1I/I8gsuyZlaTCpjkeCd88FJHL0aoBbrTZU
 6SffG5MbPd/Y3dXKpMCEPSKUhQVbufu/KhZJXgwApNTx8VsEBJU80ObBfDPrIkefyj7a
 LAOw==
X-Gm-Message-State: AOJu0YxaRCkKlSTxhHQxF6ekb8tIBjqD3DDzhnof95FHsP66+WznjeYB
 GwEUuy9LSRsoiiDDdLWM4aED8jhhVbR/atRv1Tk6k3oTSghgq+TFbpZa3GKTYx1pSnOuhfhqiuM
 9vfmGuokDgqKxaFjRymqQ5b7ilbfv3YA=
X-Gm-Gg: AZuq6aJZf+NeB5t8NuGx0xDgjzc5KhOt9vPMSruQHGD3uoIiUWylEAdRZDaIp3u7eYa
 OuxPSjnZgBSxfa6ZOsXH8O/V3ndUbG9vmoMiMic3C0577gK8EBzkiUC/QmCJAQlwsVHRrBc5sG3
 fgiNhJJar544oKGmSstQv02PXcR0rROBkQNq6W6qasr6cfFhYkbkl1aAzBrGYHWwGjoO3doCE3g
 Zkhl4voxp1eINW8U/mRqKJP/yZm/7sRMYTsK+VNDqo2jbozYe2prsEKCy091UHBMVeQFc6V
X-Received: by 2002:a05:6808:c1af:b0:45e:f092:c665 with SMTP id
 5614622812f47-462fd051d23mr1899314b6e.44.1770399521861; Fri, 06 Feb 2026
 09:38:41 -0800 (PST)
MIME-Version: 1.0
References: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
 <20260205195824.2610192-10-ruslichenko.r@gmail.com>
 <aYT9u7yO61zCOdR0@redhat.com>
In-Reply-To: <aYT9u7yO61zCOdR0@redhat.com>
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Date: Fri, 6 Feb 2026 18:38:30 +0100
X-Gm-Features: AZwV_QjzXgqsw6Cawa4QB9jJLT_qWaHfrww-kBaZ-E6ts1ZmOQe8zI7L-JtWTP4
Message-ID: <CAN-aV1FJuxZ+7L_NAo5uaFFsnTJ39hmhwQGfsajUD5B8fh1Qyw@mail.gmail.com>
Subject: Re: [PATCH 09/29] hw/core: Add Remote Port protocol thread and
 handshake
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, 
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com, 
 takahiro.nakata.wr@renesas.com, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, francisco.iglesias@amd.com, 
 Ruslan_Ruslichenko@epam.com, "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-oi1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, Feb 5, 2026 at 9:30=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Thu, Feb 05, 2026 at 08:58:04PM +0100, Ruslan Ruslichenko wrote:
> > From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> >
> > Introduce main execution loop for the Remote Port protocol.
> > Creates a dedicated thread to manage the communication lifecycle.
> > This includes logic to read packets and manage RX queue.
> >
> > Patch also implements handshake logic to verify protocol
> > versions and negotiate capabilities with remote peer.
> >
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> > Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
> > Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> > ---
> >  hw/core/remote-port.c         | 190 ++++++++++++++++++++++++++++++++++
> >  include/hw/core/remote-port.h |  22 ++++
> >  2 files changed, 212 insertions(+)
> >
> > diff --git a/hw/core/remote-port.c b/hw/core/remote-port.c
> > index 5154c1bc2a..91b0682884 100644
> > --- a/hw/core/remote-port.c
> > +++ b/hw/core/remote-port.c
> > @@ -52,6 +52,88 @@
> >  #define REMOTE_PORT_CLASS(klass)    \
> >       OBJECT_CLASS_CHECK(RemotePortClass, (klass), TYPE_REMOTE_PORT)
> >
> > +static void rp_pkt_dump(const char *prefix, const char *buf, size_t le=
n)
> > +{
> > +    qemu_hexdump(stdout, prefix, buf, len);
> > +}
> > +
> > +static void rp_fatal_error(RemotePort *s, const char *reason)
> > +{
> > +    error_report("%s: %s", s->prefix, reason);
> > +    exit(EXIT_FAILURE);
> > +}
> > +
> > +static ssize_t rp_recv(RemotePort *s, void *buf, size_t count)
> > +{
> > +    ssize_t r;
> > +
> > +    r =3D qemu_chr_fe_read_all(&s->chr, buf, count);
> > +    if (r <=3D 0) {
> > +        return r;
> > +    }
> > +    if (r !=3D count) {
> > +        error_report("%s: Bad read, expected %zd but got %zd",
> > +                     s->prefix, count, r);
> > +        rp_fatal_error(s, "Bad read");
> > +    }
> > +
> > +    return r;
> > +}
> > +
> > +ssize_t rp_write(RemotePort *s, const void *buf, size_t count)
> > +{
> > +    ssize_t r;
> > +
> > +    qemu_mutex_lock(&s->write_mutex);
> > +    r =3D qemu_chr_fe_write_all(&s->chr, buf, count);
> > +    qemu_mutex_unlock(&s->write_mutex);
> > +    assert(r =3D=3D count);
> > +    if (r <=3D 0) {
> > +        error_report("%s: Disconnected r=3D%zd buf=3D%p count=3D%zd",
> > +                     s->prefix, r, buf, count);
> > +        rp_fatal_error(s, "Bad write");
> > +    }
> > +    return r;
> > +}
> > +
> > +static void rp_cmd_hello(RemotePort *s, struct rp_pkt *pkt)
> > +{
> > +    s->peer.version =3D pkt->hello.version;
> > +    if (pkt->hello.version.major !=3D RP_VERSION_MAJOR) {
> > +        error_report("remote-port version missmatch remote=3D%d.%d loc=
al=3D%d.%d",
> > +                      pkt->hello.version.major, pkt->hello.version.min=
or,
> > +                      RP_VERSION_MAJOR, RP_VERSION_MINOR);
> > +        rp_fatal_error(s, "Bad version");
> > +    }
> > +
> > +    if (pkt->hello.caps.len) {
> > +        void *caps =3D (char *) pkt + pkt->hello.caps.offset;
> > +
> > +        rp_process_caps(&s->peer, caps, pkt->hello.caps.len);
> > +    }
> > +}
> > +
> > +static void rp_say_hello(RemotePort *s)
> > +{
> > +    struct rp_pkt_hello pkt;
> > +    uint32_t caps[] =3D {
> > +        CAP_BUSACCESS_EXT_BASE,
> > +        CAP_BUSACCESS_EXT_BYTE_EN,
> > +        CAP_WIRE_POSTED_UPDATES,
> > +        CAP_ATS,
> > +    };
> > +    size_t len;
> > +
> > +    len =3D rp_encode_hello_caps(s->current_id++, 0, &pkt, RP_VERSION_=
MAJOR,
> > +                               RP_VERSION_MINOR,
> > +                               caps, caps, sizeof caps / sizeof caps[0=
]);
> > +    rp_write(s, (void *) &pkt, len);
> > +
> > +    if (sizeof caps) {
> > +        rp_write(s, caps, sizeof caps);
> > +    }
> > +}
> > +
> >  static char *rp_sanitize_prefix(RemotePort *s)
> >  {
> >      char *sanitized_name;
> > @@ -105,6 +187,108 @@ static Chardev *rp_autocreate_chardev(RemotePort =
*s, char *name)
> >      return chr;
> >  }
> >
> > +static bool rp_pt_process_pkt(RemotePort *s, RemotePortDynPkt *dpkt)
> > +{
> > +    struct rp_pkt *pkt =3D dpkt->pkt;
> > +
> > +    D(qemu_log("%s: cmd=3D%x id=3D%d dev=3D%d\n", __func__, pkt->hdr.c=
md,
> > +             pkt->hdr.id, pkt->hdr.dev));
>
> This kind of thing feels better suited to being implement with
> QEMU tracepoints.
>

Agreed. I will replace the manual debug logging with standard QEMU
tracepoints in v2.

> > +
> > +    if (pkt->hdr.dev >=3D ARRAY_SIZE(s->devs)) {
> > +        /* FIXME: Respond with an error.  */
> > +        return true;
> > +    }
> > +
> > +    switch (pkt->hdr.cmd) {
> > +    case RP_CMD_hello:
> > +        rp_cmd_hello(s, pkt);
> > +        break;
> > +    case RP_CMD_read:
> > +    case RP_CMD_write:
> > +    case RP_CMD_interrupt:
> > +    case RP_CMD_ats_req:
> > +    case RP_CMD_ats_inv:
> > +        /* TBD */;
> > +        break;
> > +    default:
> > +        g_assert_not_reached();
> > +        break;
> > +    }
> > +    return false;
> > +}
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>

--
BR,
Ruslan

