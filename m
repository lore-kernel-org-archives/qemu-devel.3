Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9CFCD98D2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 04:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZLYt-0002Cz-Tb; Tue, 16 Jun 2026 00:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZLYd-0002Ai-QN
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 00:37:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZLYZ-0005fX-Nv
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 00:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781584666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qZ16rfsoVF4zvOgUbvB02/L+Slz72BxNHafNlCCZ6nk=;
 b=KC9Sdrs6WER+uim72PwndKuRLlDK46dospbeOkTSXrNxmc3YiU39o9k5uIr4X7lPngcCrs
 ofnhsVaxYqSR7lb28h6wLma8FwEEYNM02Gf1pVK6sLQ+G+aiZQKP10g7ltxTsoOLTuye9T
 AKiaDPq3wHAJtGiCiiWS1XFEGDyuw4k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-pTgwK6OjMRe5UwjIo6hUlg-1; Tue, 16 Jun 2026 00:37:44 -0400
X-MC-Unique: pTgwK6OjMRe5UwjIo6hUlg-1
X-Mimecast-MFC-AGG-ID: pTgwK6OjMRe5UwjIo6hUlg_1781584664
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45eee3f9f03so3694522f8f.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 21:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781584663; x=1782189463; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qZ16rfsoVF4zvOgUbvB02/L+Slz72BxNHafNlCCZ6nk=;
 b=sTsGLgWBj8HFQFwJFlsxWFCi3Wk5TQDZhHSMcA10NsTdX0ofbwGNcp0kip2Psgn9yZ
 gF+CUCJS9VocUfNtHjVKqb7cHnwPHl/RxRoN1fxMgSX+Vbx+ogaX5UIv5sqR4iQGRsuq
 0UFRgoL4dZ3fvcQtjp1ttJ6a2c796j+1VuxvGZoyDcd2oB7OFeh/fvX5rBEi+VWEHjsE
 pgDXkySsEsTc2p9WK90Cn0Zx57r3JqLCrxgu+dKhj8itLCTGmY0uONMxrva9/FEXJRo6
 43bly2jRXsArx8H4jyXxzuoN53LiKGWuKD024JPiXFyhHcX0ywIRRP5UIosJMwjztHzF
 xErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781584663; x=1782189463;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qZ16rfsoVF4zvOgUbvB02/L+Slz72BxNHafNlCCZ6nk=;
 b=YNWAQ2+MImF2aVZDKGQQbHU/KRVD4UA+TNn7Z+3xyUDWq0iuCSpLyx9nWK26Ui7XOc
 Qo8TB8A21YNgpm2K+6PtW7ucFwZLnNdENNx0h7YF/McvMvmphYprSacW8pwTON8dJPsp
 /CJac46NBGY13Z0CeTmMl/aaR4uYc9yySoe+uMT7/ArIZlFUX+gd05TK8uSwzSc4fQkz
 0iwHQdDBmKCtpTGlkI37yeTBy3SahUWle9ktbGpL4EULRf/Jn4I5uVHiUldOWKjUMkeh
 rm5C8TbnOfOzXhinfJJcT2UQFE91xy7cn+IWPrrbwMRycxhj0qPGUG+E9PV+6YDEWXdr
 fCoQ==
X-Gm-Message-State: AOJu0Yxp5bi6hGNbnmYBdjTP0/1FB6rS2xfl0CGgdh3IEFiajOE0P44A
 aiA1XyWNLevfDkFe2Cx20SLAuKBRt5HkGEVMGGxUXhArrKFLcsmfQOTLD8bSZvO1hoztKlmql+z
 4U8hJLvIL8BJeS6K1v90ytvxEnnXHdVk2xpAbh58rVC/nAXdUCZmP8z2l
X-Gm-Gg: Acq92OFGbnGo/N5e8/q6K/KDlZBMm7+3R35xsU90mbfx+UfyvpwY38KNJ+ZE+5MFTmh
 vDIbhRyzsyVQtcac0yVy+NfW9I/Mg/sK1g+BCsDWST5jsyZx0D37qZ0+cY8fELOot+oe0D/dNU4
 y/yWKZrEw0V3RAfTD3O8KPkQpIRV+Fma2dlt7PKjqeyaH/5OrmyO/mhpZXjFCPK6kwaGN+qjzEq
 iUmsaLlYckCQ5xTyj0gcpM/K/KqCiVRnygEQSFtp8UlWxWTrxQepgOeQBy0b+jHsLEjP3yfikN0
 Y4CRcw8BPuGqLxu5GM5EQibyhvTUhTJkQIQg/tUdtB7tw1BrPAUXrj59r7tP1Sng/jrpmW5pLgV
 4vIuHyCOMMmJH7XBMsG8mfwaHXmlj4i5aMVsZoUV9mB8=
X-Received: by 2002:a05:6000:290e:b0:43f:dfb6:78e1 with SMTP id
 ffacd0b85a97d-46074a87cf0mr19722453f8f.8.1781584663469; 
 Mon, 15 Jun 2026 21:37:43 -0700 (PDT)
X-Received: by 2002:a05:6000:290e:b0:43f:dfb6:78e1 with SMTP id
 ffacd0b85a97d-46074a87cf0mr19722419f8f.8.1781584662936; 
 Mon, 15 Jun 2026 21:37:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f1cdsm42321541f8f.11.2026.06.15.21.37.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 21:37:41 -0700 (PDT)
Date: Tue, 16 Jun 2026 00:37:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: helei <lhestz@163.com>
Cc: qemu-devel@nongnu.org, arei.gonglei@huawei.com, zhenwei.pi@linux.dev
Subject: Re: [PATCH 0/1] hw/virtio-crypto: add akcipher keylen validation
Message-ID: <20260616003707-mutt-send-email-mst@kernel.org>
References: <20260606074756.43804-1-lhestz@163.com>
 <20260606043251-mutt-send-email-mst@kernel.org>
 <392e03eb-63e4-4db0-89d2-b7ddc32b91e8@163.com>
 <20260606102015-mutt-send-email-mst@kernel.org>
 <9b5b6607-13f5-4b61-88be-d8386a0d1b00@163.com>
 <20260609115607-mutt-send-email-mst@kernel.org>
 <a1b9d24d-8467-44ec-92fc-6684b243bf41@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1b9d24d-8467-44ec-92fc-6684b243bf41@163.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 16, 2026 at 10:50:24AM +0800, helei wrote:
> 
> 
> On 6/9/26 23:59, Michael S. Tsirkin wrote:
> > On Mon, Jun 08, 2026 at 10:35:14PM +0800, helei wrote:
> >>
> >>
> >> On 6/7/26 10:18, Michael S. Tsirkin wrote:
> >>> On Sun, Jun 07, 2026 at 08:15:19AM +0800, helei wrote:
> >>>>
> >>>> On 6/6/26 16:37, Michael S. Tsirkin wrote:
> >>>>> On Sat, Jun 06, 2026 at 03:47:55PM +0800, helei wrote:
> >>>>>> The virtio-crypto spec does not dictate a maximum length limit for
> >>>>>> asymmetric cipher (akcipher) keys. We added a hard limit which mirrors
> >>>>>> the linux kernels's internal limit for akcipher keys (see
> >>>>>> keyctl framework and the add_key syscall).
> >>>>> We have max_size - doesn't that apply?
> >>>>> backends/cryptodev-builtin.c actually sets it:
> >>>>> backends/cryptodev-builtin.c:#define CRYPTODEV_BUITLIN_MAX_REQUEST_SIZE  (1024 * 1024)
> >>>>> backends/cryptodev-builtin.c:    backend->conf.max_size = CRYPTODEV_BUITLIN_MAX_REQUEST_SIZE;
> >>>>
> >>>> Thanks for your review!  I have verified via testing that all processing
> >>>> requests in the dataq are strictly
> >>>>
> >>>> bounded by max_size, but session creation requests in the ctrlq are not.
> >>>
> >>>
> >>>
> >>> well if we read the spec it's vague
> >>>
> >>>   max_size is defined as "the maximum size of the variable-length parameters of data operation of
> >>>   each crypto request's content." and
> >>>   The driver SHOULD read max_size to discover the maximum size of the variable-length parameters of
> >>>   data operation of the crypto request's content
> >>>
> >>>
> >>>   so data operation.
> >>>
> >>>   however:
> >>>
> >>>   "The device MUST set max_size to show the
> >>>   maximum size of crypto request the device supports".
> >>>
> >>>   seems to cover all requests?
> >>>
> >> the original architectural intent was almost certainly for max_size to
> >> govern data-plane payloads, while control messages are handled by their
> >> own independent limits (max_cipher_key_len and max_auth_key_len).
> >> both upstream linux guest driver (virtio_crypto_skcipher_algs.c) and
> >> qemu's builtin-backend actually implement it exactly this way:
> >> - data path enforces max_size by checking it against payload length
> >> (note that cryptodev-builtin recently capped this to 1MB via CVE-2025-14876)
> >> - control path completely ignores max_size when creating sessions
> > 
> > we can add akcipher key length feature but what to do about existing
> > guests?
> > 
> > could max_size be a way to fix it?
> > 
> yes, using max_size as a fallback hard limit across all virtqueues(both
> dataq and ctrlq) is a very good way to close this gap without breaking
> backward compatibility.
> as for existing guests, virtio-crypto spec only defined RSA and ECDSA
> for asymmetric services. even an excessively large 16384 RSA key is only
> 2KB, so no well-behaved guest will ever be affected by a 1MB boundary on
> a session creation request.
> 
> note that if we take this approach, we should explicitly check both the
> algorithm-specific limits (max_cipher_key_len/max_auth_key_len) and the
> global max_size boundary across all session creation requests.

why should we?
one could argue alg specific limits override the max_size.


> >>>
> >>>
> >>> btw vhost user sets max_size to max u64 - is that sane?
> >>>
> >> this is sane for an out-of-process data plane from a transport
> >> perspective, but it creates a practical catch when backed by a dpdk
> >> implementation:
> >> - in dpdk vhost_crypto.c, vhost_crypto_check_cipher_request() enforces a
> >> strict check: src_data_len <= RTE_MBUF_DEFAULT_BUF_SIZE (2176 bytes)
> >> - the guest kernel driver simply wraps the incoming sg list and passes
> >> it to virtqueue directly.
> >> this creates a tricky situation for users: because vhost-user claims
> >> max_size is max_u64, the users has no way of knowing this 2KB ceiling
> >> exists unless they explicitly know the host backend is dpdk and look at
> >> its source code.
> > 
> > worth fixing maybe.
> > 
> >>>   
> >>>
> >>>>>
> >>>>>> Maybe we should update the virtio-spec and add a max_akcipher_key_len
> >>>>>> field for virtio crypto devices.
> >>>>> maybe
> >>>>>
> >>>>>> helei (1):
> >>>>>>    hw/virtio-crypto: enforce max akcipher key length
> >>>>>>
> >>>>>>   hw/virtio/virtio-crypto.c | 13 +++++++++++++
> >>>>>>   1 file changed, 13 insertions(+)
> >>>>>>
> >>>>>> -- 
> >>>>>> 2.43.0
> >>>


