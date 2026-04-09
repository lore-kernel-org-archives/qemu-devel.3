Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF324EA3C23
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 10:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAn1K-00009G-P1; Thu, 09 Apr 2026 06:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wAn1I-000097-Vg
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 06:53:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wAn1G-0007eC-1H
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 06:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775732032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aH8EYGVmRIg72V1Pgnm38S53Ly8d3QbMpZRRw8MwNaM=;
 b=GjfrXOAyJTbvK7CPzBuHrQJlmSBuXWy8270Rv9/01VXDFLeM2JllEIj4tfHaLnMpOXbd3q
 XYVAiu+CNqX7j9lGA5Gv+iFtNs2owDN39DCMLs11mJpiRjcpQDwbV+ddx9mnj0qwRtSUDM
 OC9qn6mHYwLlx7vtKcSkdnPn6ad1Llw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-_LNMLL_xOSup3YJdwd4c0w-1; Thu, 09 Apr 2026 06:53:51 -0400
X-MC-Unique: _LNMLL_xOSup3YJdwd4c0w-1
X-Mimecast-MFC-AGG-ID: _LNMLL_xOSup3YJdwd4c0w_1775732030
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43d14a4bcd0so982073f8f.3
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 03:53:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775732030; cv=none;
 d=google.com; s=arc-20240605;
 b=iH7U+5bospo5Mb3oJcWTBi0qEqsklGOPThBV54htVroA05+TDhmKBiewOTeX3ms+jW
 elkkJh2kfXphUFQhDtk6WeCC7cpRCpGGFZerYH3G7PI/0DiMog5vrQ7qJGV05VqQoOPY
 OF9mFV3ouU5X3HqRj6gXXIBhYyIrpFJUWEaPe6v2JPuS6fiPofMjFRX59lSRVrwrFa0h
 /NRlQB+NOw7AotUSjWRb3QSN/xsxUR9/zIf/THy3IKMEOofsKoOrpyQXTrlFsNOh6Gq2
 lK1bItJSDlOkSFzNXO4JfcSq5fZsEBGx7QeSActkWbdkGBa2QnmJDdrbY5ifHvYURz9B
 7BZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aH8EYGVmRIg72V1Pgnm38S53Ly8d3QbMpZRRw8MwNaM=;
 fh=sWcw3HoY1LaCt8qN2YujPvFLN2rsUTf8ZQNrxkcqM6c=;
 b=K6417zDwqRT+JiEeQQY2V2Hgvhe2DJGFImFob14bBAfmwojiJZZxibUePd4CdkMKMJ
 E+TyvVw886ceQbWQV5uRyJ3Qrh4eJmu7lMYCd/JsGkNOjJpwhDLH2Ef9ja463fx+UaRM
 wMPLFrioLx3V5GJJi6GGhfq0YPjTGwCCUw65kxxwLjT+me4npGvL0Sb+YyYYZrG6OsFR
 Bz0OGUMfx34tzRLFAZKymPAW7oMhzJalS55toXc/ouZUpAx32ZYWCGK7oXH3f6z1aqnl
 7K/ZTRDAAv2QlcEnLD13LYAVdVtO3IJ+13DOTaI2dHUvjWU981j80nbCcYFT6OTug4Ba
 SoTw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775732030; x=1776336830; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aH8EYGVmRIg72V1Pgnm38S53Ly8d3QbMpZRRw8MwNaM=;
 b=r1bv6xqSCqJ2CBXnf2+quR+TPaHauZ4FoNt2jmJqS+TRSEGEIkmtdl/B63cE2+12sY
 OYQNCdnQqh+8DViqL0wrHD0s5nfpy+gp2MKARu3k8ZE6QSI+4u2x5qkhc7PNDISnSFla
 +CBccxXPbXwrcB5JugooKcn8Bf6eVnLPdbZm2G4WcM89j9zN6L5HFs0AGrSJKzKZ/6QH
 M6FUXW5s5kP0aDaJehP8T2cApzV3ReVC7zbSAbcredceJ6NHJK5rLbLvv32XfZn0Sa/Y
 kykDH0ucLlupH38StQyvGMAKZdMQjVb1AISoAJSgRSBlf6Td77u2GxhXVVbcEqTFTOIB
 Q3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775732030; x=1776336830;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aH8EYGVmRIg72V1Pgnm38S53Ly8d3QbMpZRRw8MwNaM=;
 b=ZmtmABDCYETBCyy4RsQ3DrHD4Ll6RnkvP/wgBcZ17PUXjfCw+Z/NdParTVvWk0Z7UN
 3IqlkulBnLsnJqy3/oUfET5FsvxBv/bXUIk5ruUDp5fJJGzW6763NyxnaWdRK/+cSWeW
 D+U5G5HS8HUpqtS1PZbmuYVQpE7V2NYKwFLdXSWPYywmDgsmf0RCTsn6CLiU7fmpRU/r
 DTmlelPVgo70qIhAV+Hv0L8+/doP8yiqrEODNwSultFKrlGdaxHXCWmU0HS0Jb/AyTf4
 x/2FFsDQCmi4cF9YKUpqc2k+odtpSmznS0MT+OKsd/uWCLPM7cGSw2p2WRTFMHLIzPnM
 dtlQ==
X-Gm-Message-State: AOJu0YynlkdXz8d7COZHOTDxamhWBM9UimtI2/CLV9PLFnNkX3jKPRiu
 aU5T8SmzGmnIxMTkNdhIGdFZCIWmpBBIDnzs7znl9h6cc1VqoYwzmC3eCnKRExXkjiCrcy7j72u
 qDSdDj30D4y09N5jmaIIEpNKU/kRF2KiU/XlO437fCWHYd8bWbc2Ec3TKt1WPRA8UM9VPnWMumg
 Ab3/9txQSpkO2N0wuyg7sjhFF0RlYG7HA=
X-Gm-Gg: AeBDievbyR+VuL7E9DZoYF4Hm4m3aL3Wkt7NDE9VggWwKbz7ZdBemyVO96iXXqwB918
 kWPXhuYjWk0nAGcIiFNKlLbhqM7L9loRA7i7DFyWoGvMq5ZGE1WKWMG+0caK82ZTkV2j0uqnj/Z
 rNqrSnnJACQRCn1kHsm8Zz2TkHU8KD5pbSSGwP1Imi8uPKV8KwXcluXHwU8eNOJjJG0os/lrGA9
 yBYP6HO7vKMbZVN5Ek24OwXz9Pem+ioYnFFceh2VlH7tdQ79z1BoK/PSxOINO1Ij/a7aJ/xl1cf
 i7gK
X-Received: by 2002:a05:6000:310a:b0:43c:fc5c:a9fc with SMTP id
 ffacd0b85a97d-43d2929dcd9mr36372054f8f.21.1775732030228; 
 Thu, 09 Apr 2026 03:53:50 -0700 (PDT)
X-Received: by 2002:a05:6000:310a:b0:43c:fc5c:a9fc with SMTP id
 ffacd0b85a97d-43d2929dcd9mr36372022f8f.21.1775732029754; Thu, 09 Apr 2026
 03:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260409103310.1884968-1-pbonzini@redhat.com>
 <20260409103310.1884968-2-pbonzini@redhat.com>
 <adeEHeacVSfEKp-V@redhat.com>
In-Reply-To: <adeEHeacVSfEKp-V@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 9 Apr 2026 12:53:37 +0200
X-Gm-Features: AQROBzB5-JU4C8nX2ddRvXfeOXmiZO1W0OcVrhJmf-UI_2t_tl8y9CiC7P9bxHw
Message-ID: <CABgObfZ=dGwYMNsxvJb6pd++UQGhZj5D22qs42Z30vce3R9HMw@mail.gmail.com>
Subject: Re: [PULL 1/1] virtio-scsi: pass the same cdb_size to
 virtio_scsi_pop_req and virtio_scsi_handle_cmd_req_prepare
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Jihe Wang <wangjihe.mail@gmail.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Apr 9, 2026 at 12:49=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Thu, Apr 09, 2026 at 12:33:09PM +0200, Paolo Bonzini wrote:
> > Ensure that there is no allocation/usage mismatch when requests
> > are processed in virtio_scsi_handle_cmd_vq.  To do this,
> > retrieve the value once and pass it to both functions.
> >
> > For other calls to virtio_scsi_pop_req the extra size
> > can be 0, because control and event requests fit
> > entirely in VirtIOSCSIReq.
> >
> > Reported-by: Jihe Wang <wangjihe.mail@gmail.com>
> > Tested-by: Jihe Wang <wangjihe.mail@gmail.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  hw/scsi/virtio-scsi.c | 26 +++++++++++++++-----------
> >  1 file changed, 15 insertions(+), 11 deletions(-)
>
> This issue is tagged CVE-2026-5763   - if possible can we get that
> in the commit message before merging.

Done, new commit hash is 79971302935472232a68073faddb085177e3ca54.

Paolo


