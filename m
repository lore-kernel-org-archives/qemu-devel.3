Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2095EC5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 02:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxFSJ-0004eX-9r; Thu, 20 Aug 2026 22:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wxFSH-0004dm-1j
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 22:58:05 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wxFSF-0007r8-DT
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 22:58:04 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-51c04bf4711so4368801cf.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 19:58:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787281082; cv=none;
 d=google.com; s=arc-20260327;
 b=f76geWp8A3grayz8C4Ki9sCO70DlA5F3Ca72aXbxZPz+/rLs8rz9cMbiBL00WBnv7z
 jbGqNYoxqZev4LGScWexJJv+Ny9b26BsaMj4hsHdI1EVVKGY56HGULNpOTOVtZ2qs4Kv
 IqfTSvLN/yA955ngBen7G8VryEe2BE951Cc9eFnYANbp5D9jV6J+sZot9fA8QHQ/zJxZ
 tPP6uFRfzXqhCJAp82fgfj2FZ0G1uzz3ny39J88oRictIXZa9JJveMoB7gpJfciDNqmW
 Bes1kYUIfkO8Kp4HIKsqpBZqFDPVdVCRxe0qmUoGBtJfwMQz0OyHZdJYeol8Qi3cFE5N
 Y/+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zSNmTPaNindB5nxKaFCyV4uOayvfqWNLHa5LTnes58A=;
 fh=zAf9Wul48xkTrIs6bAeEfpaQhknOU2iSq1CvwgfZtyM=;
 b=i1xHzVVqPr2EpVcgbb3scvte+eb2KiaQ1wYOlcQ2GsBpXFaJ++rGQbtWhwykFQLICF
 vYd4S+KaM5tWVXv0lX9KvKVsESoCskobVZABathr9Y8TiUzABCl4v0v11dR8Yldhy6UB
 X1TaDmUJT/nR9GKvFjn/u2e7Z6FKjc0EWaRq+4bhP8817OaYvgFtuDr+CKAqsw7+1zTZ
 OnTlqOLqOqKJFGqaeuCMh70RCkIw4P0iVC0lgC6ZYNh+9CQPN9w9RBSh+wGQZw9uCDsO
 pXNJlHCLHUWeWq5aZxqEOul8TpIVSgXkgWZt51d4YhS5A1zz7MjWWhvKPJ6RUy0Z5Hs5
 lTEg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787281082; x=1787885882; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zSNmTPaNindB5nxKaFCyV4uOayvfqWNLHa5LTnes58A=;
 b=bT6KsCnopDmGHWjjjRV5GO/zk6SuXsEWdMsLjAj4wHGLQa6+MCgKoSguvc20f9apvu
 /e4wZltn5DkjQOy0vEtcCBFHwPrjew9Urfrna2yyKOKpt4IKdYvkgtbj5aMBAr3iWXDn
 7D0Tv7Q1Y8JYfJq2nU+8oPrkh6oubbetiCfVCPoVB1kr+KawAs58eI6aR2ahJq1pyDIu
 8a9ECIsIoOiAtYCXfYrZT6676TiorpxGnjj21Cduw076LJLQSp+Ry9J2TDVINhEhxMKS
 O59fLlhzzMNNe7ej8oY/lQivi3XID1t0s4QXFt/9yAcyR4rTTzqKX1Upj5ou7z3KKMug
 IKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787281082; x=1787885882;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zSNmTPaNindB5nxKaFCyV4uOayvfqWNLHa5LTnes58A=;
 b=QFZQIGNaNIT7o033Qpk9suWwvd0VHmxgaeMvOCzMwBEWlrYjUFc+xvByZRokIDb7Ii
 lqsv8tF2I1m70dnyIfgSfB04eJ6hb+zYoeeFlmiZCP5ACDrbg9/ypwNDdlspoNiLolZ9
 Z7ucN8fy2M458lEdUMLqI4g3RNLL9zpofA148lem+j8TH+Jg0hbt4Xy1A/V3Z1IBl6mN
 XOyCGUGmWTniZZ5YU6N37BRp0tUuK01XPrnPcaWPZr7/9F8G0YScq69TGt2ux+tisngN
 mkgb72RZihhL326xXd9U9EUkMVERV+bxThmNBcs2DoQKsng5iOhM1HJN3wcJZmdkWxd+
 yFwg==
X-Gm-Message-State: AOJu0Yxy+g9Y6me3I/IxQNkRsumvXqBJwmZ6nJin4PA6ofpPgKy/Hzt5
 F6hiBILVcI9VCm+bAPq3RG+Sfysr4YF7NFL3H0v8PX7eA9c9U4N7y/LoCaA/fMLhZBuOz/kLTog
 5kySraKlbCV8630IzyGanXg6eY+kBgYA=
X-Gm-Gg: AR+sD12wYJfY1PC0ss6JoBmZ37kTmxZJ/I+RmWjQ2K9hb5CEjccgVLFzcwHyFpxc0pC
 Cj0/qwyXlk3gzAaA6J2/adByJq+CTyh7PsHQUUI5Wivo+t8CJC4ADqUQNdx7MJnugkLV9YIMSpm
 BO6rYM8+yn8Qc5O//diZuNmsRs/ij7Vhko8vumaKQf/qiI1DjA64FcMcrH894z1dO5KWVqhmH/M
 XXbn07nLtNa9ouAcN5aH8hv4Rd995F3785Dmvb7Z+0Dg/isnBCydzcy7YICPTthcPfGR4LiZj0N
 7OPvYqLQqpmAzdMxA6v1aHLBRQ4MrQu8DmgvVxsKfC9cijpDnueMFgmFAGRpW2qUZI1IA/V206G
 kbXJEMwGW/brkwg==
X-Received: by 2002:a05:622a:111:b0:52d:6cf5:1c01 with SMTP id
 d75a77b69052e-52df5a73d25mr28383211cf.36.1787281081993; Thu, 20 Aug 2026
 19:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
 <20260817-vhost-user-isolated-memory-v2-7-948aae960abb@gmail.com>
 <ab5f4ec8-0ef3-49df-94c1-b7145d4153d4@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <ab5f4ec8-0ef3-49df-94c1-b7145d4153d4@rsg.ci.i.u-tokyo.ac.jp>
From: Connor Kite <connorkite@gmail.com>
Date: Thu, 20 Aug 2026 19:57:50 -0700
X-Gm-Features: AcwNN1UfP1iX8bGmorWimeRMWt5bx7-t2Md_OfCGSwYi-defJG8tPospdb8vZ94
Message-ID: <CA+spn3qk45YZC6FDMFk9FAr6aM=OziGfbeNwmScoz9DOU1rawA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 07/13] hw/virtio/vhost-user: create isolation region
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=connorkite@gmail.com; helo=mail-qt1-x82f.google.com
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

On Wed, Aug 19, 2026 at 12:36=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> > +/* Memory region shared with back-end when memory-isolation is active =
*/
> > +typedef struct {
> > +    void *shared_mem_addr; /* mapped shared memory */
> > +    VhostIOVATree *tree; /* controls mapping of regions into IOVA spac=
e */
> > +    void *vring_hva_addr; /* beginning of vring region in shared memor=
y */
> > +    size_t vring_region_size; /* amount of shared memory reserved for =
vrings */
> > +    size_t size; /* size of the mapped shared memory */
> > +    int fd; /* descriptor of anonymous file backing shared iso region =
*/
> > +    Int128 iso_iova_offset; /* translation from IOVA to hva of iso reg=
ion */
>
> This Int128 usage is misleading. The value derived from iso_iova_offset
> is always consumed with int128_get64(), which asserts the value fits in
> 64-bit. But we actually need to enforce that the address before
> translation resides in the shared memory. So making iso_iova_offset
> Int128 is not a good way to assert the real invariant.
>
> Furthermore, "[PATCH RFC v2 10/13] hw/virtio/vhost-user: handle data
> movement with shadow vqs" has:
>
>      ptrdiff_t offset =3D u->iso_mem_ctx.iso_iova_offset;
>
> If defined(CONFIG_INT128) && !defined(CONFIG_TCG_INTERPRETER), this will
> overflow with u->iso_mem_ctx.iso_iova_offset > PTRDIFF_MAX. Otherwise,
> Int128 will be a struct, which causes a compilation error.
>
> uintptr_t is sufficient if the invariant is enforced in some alternative
> way. A negative offset would be represented as wraparound, and a
> positive one will never result in wraparound. Just always ensure the
> address before translation resides in the shared memory.
>
> Regards,
> Akihiko Odaki
>

Your point is taken on the Int128!  I also got similar feedback from
Stefan Hajnoczi and Hanna CzenCzek that it was unnecessary
complication.  Will move it to uintptr_t and double check the
bounds-checking on translations in the later patches to confirm that
it didn't depend on the Int128 type.

Also, I thought I had moved all cases of ptrdiff_t to Int128, but I
apparently missed that one.  The offset must have been less than
PTRDIFF_MAX in testing since this didn't come up.  Will fix and change
to uintptr_t as well.

Thank you once again!
Connor

