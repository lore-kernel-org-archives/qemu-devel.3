Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24EE7C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whVFg-0002zy-8A; Wed, 08 Jul 2026 12:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1whVFe-0002zh-Ue
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:35:58 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1whVFd-0001qe-Ar
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:35:58 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-845c92bc464so630880b3a.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 09:35:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783528555; cv=none;
 d=google.com; s=arc-20260327;
 b=Gn+ZQgn4ME4fQpPWqRj81oui2wmi0pLwpFQtDArFXvJw4FzUmxp0cWaYW2WsoJl8uN
 dkmz+2wmWHnWdiLQK831jcLp2mmZYyspcIu6i5swggXiESwvLrTuHV4ZAaDYLgC4DmL6
 QckQU2brMKh4+oOiAOeCYqm13KgOwB16mwrfq68Oqx5JVvL+KgTrpqeyZWIfXmrrk3XN
 njDlalDxu6ivK58afgS44v9v5VdYA3KeOyGiXaC17TLh3rWXAPKdO3X0gw+4K9nVz7ao
 hnn8nLl8vZcEOoER+mdiYrvcILzseNxXAw1o7Dg5bLWW53vevARkLgR0qrMwEyyn6kJM
 g+1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=S2Yq24g94kbE6BiMhj841mCK1uDW2HgOelcfryU6fFU=;
 fh=XzYYY6zGuaeK7RpC0JkE3KAzbewp6R2ig/Zl+XwuABE=;
 b=mrngKN/lJQ4onSm24vyhE74u6lOqVyGUQ91P28h+ZO2S7YhDhaSHiCwCS8iuReIMnx
 cRTCVbejsiS2mkIqnRvWcbzVB80LZvUY+Y6AYfJbQxVF8R8IVU5MclOZ1QGYQOl6O/F7
 D19B085G2FPTykDG4TQyGCRLCjcrXJN/KDPH3jnjx9Bxo9QSSMecNMAlf3hQdWZ6kG6y
 Cwbvt7ns6hFvG9YwZ5xO2qCWGXj94PfbnNOd2rADXbq0u/IMOOYqYmXVlMvlvWN5uVEu
 gKC6keQw+MJxxIp2odzqG9SZo5lN0tp+dpRLHjnY1msWfSYi594bpbV5KCiHXw0M2W/T
 sE6w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783528555; x=1784133355; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=S2Yq24g94kbE6BiMhj841mCK1uDW2HgOelcfryU6fFU=;
 b=Fo5DjrpLdOJ5BeZg6a1bkocXrKrin7Lwo4aOqwZ9yCTFTIkFfPK9JJe+FwwDvS0ql8
 TiBG0Z1zaf/0IZVLw0iIDb1Lw4/J1YvEZASv7Bcr0Tpr676LU5/kgf0TQJRwxvWzMO9h
 tn+YSQmGcaAzZb3clh+1dpIO0Gx9mP0W6RNBpQB2NYJVdUdxidaIYGb0XwTSbcGGQLtV
 XNvO6QFDKB2nTpGQ57rvTU/ZefE/bot6Uho9fIvLrr+PeZ4YZyx2TGxjkCQpjJ6cL9/C
 +EAcbqO/vs3fzmN1OjGCijQHe5ocZPfBEVlu//vrO71PbMRsK2WYOtZzEQW7pQ0LvA5Y
 v7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783528555; x=1784133355;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S2Yq24g94kbE6BiMhj841mCK1uDW2HgOelcfryU6fFU=;
 b=FlR4PcwVWlVoAdXy6jHly0mWX1keZNsjUWyyHS6+bzxE68bo4Gs0eSGlElxkGgYOpj
 0sN5C/wOHfEYQ7O/ifSt2BNcWLaKtYLv9OwgRZDU+SG7fFEULzsmb97qF2uABI4eO7Vb
 3aHDsVaw7iNPi6DRuEmcHqTOI9aZsqsNa8OJU6aOy2aHFUOonxB1JT83v+CkrXmKUe/d
 glfIqOspBiHjCGx8ppVrx7q+iS0/TfjeED0z0u+pOKul+fwJhhtIUSFN5tlEXzB/iNh1
 wmFKOkug4B9YIao5s6qqcvMW2IWb5rNIfOhA1aKUVWEWFLt9C7Hp4+GO1hf/FvfHBe7u
 THOA==
X-Gm-Message-State: AOJu0YzufWTpXeKlHvnMCu9Zsb65m+eCwi9fqmU8HexfjUXQROsH6x+0
 GhHimPRPqecaBqpuLTmmsu5VHE5t5Lw/yO/5vU7AxkNK7TqFOnjxxxqtlabFkujjrN9lM6fHHj8
 XUSRt7GszBVEvH3NEBwVDHkmsqNqnRm4=
X-Gm-Gg: AfdE7cnjUzU3PN87eVXU3m0N+Ph370LikeeOqWnmZa5FKyC/OJWSJguFUp+hD4c0vc5
 NJqnxRwjSOMCgNP7Je2Pnedgefg3E/Q3Hw9EgOE2V9fbvDzCTqXaAA8SdMGJuR6LRjYfSDmG3KI
 uVPoGU6B7A8KqwH4rDOkEl+3jtwDNBzjsX4MejaHSbe8eZJLqpd2LQUBeDvYlb34yMSbnoRcx7x
 MInHW/lQUM1qiA7YxAtCZnKF5q8cScusEgGsWt8OtfFFbV7bMxztPjMxPipp/RwkHMCYXhj523R
 GQ1QCvB4YkTSRv6gjI9E4xNrO2yDt5T9D5Zpgkrph9Ln4IwqxFTgcbyFv6dkIwk=
X-Received: by 2002:a05:6a00:a90e:b0:848:3e69:4ba6 with SMTP id
 d2e1a72fcca58-84843663ebcmr3060390b3a.54.1783528555545; Wed, 08 Jul 2026
 09:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260623184830.373232-1-faithilikerun@gmail.com>
 <20260623184830.373232-5-faithilikerun@gmail.com>
 <20260629182347.GB376767@fedora>
In-Reply-To: <20260629182347.GB376767@fedora>
From: Sam Li <faithilikerun@gmail.com>
Date: Wed, 8 Jul 2026 18:35:28 +0200
X-Gm-Features: AVVi8CfvePmOvYWYuWdrUCxb9buqCfs2RsEAC-_BgrK55OVZ6uWn1wQc-aNFSXw
Message-ID: <CAAAx-8L-E9Y7vrkc5x0bEjgzTEOgJT5xkGztW46jnz44uPs-MA@mail.gmail.com>
Subject: Re: [PATCH v12 4/5] qcow2: add zoned emulation capability
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, cassel@kernel.org, dlemoal@kernel.org, 
 qemu-block@nongnu.org, dmitry.fomichev@wdc.com, 
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=faithilikerun@gmail.com; helo=mail-pf1-x436.google.com
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

On Mon, Jun 29, 2026 at 8:24=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Tue, Jun 23, 2026 at 08:48:29PM +0200, Sam Li wrote:
> > +static int coroutine_fn GRAPH_RDLOCK
> > +qcow2_rw_wp_at(BlockDriverState *bs, uint64_t *wp,
> > +                  int32_t index, bool is_write)
> > +{
> > +    BDRVQcow2State *s =3D bs->opaque;
> > +    uint64_t wp_byte_off =3D sizeof(uint64_t) * index;
> > +    uint64_t cluster_file_off =3D
> > +        s->zoned_header.zonedmeta_offset +
> > +        (wp_byte_off & ~((uint64_t)s->cluster_size - 1));
> > +    size_t off_in_cluster =3D wp_byte_off & (s->cluster_size - 1);
> > +    void *cluster_buf;
> > +    uint64_t *slot;
> > +    int ret;
> > +
> > +    assert(s->wp_cache !=3D NULL);
> > +
> > +    qemu_co_mutex_lock(&s->lock);
> > +    ret =3D qcow2_cache_get(bs, s->wp_cache, cluster_file_off, &cluste=
r_buf);
> > +    if (ret < 0) {
> > +        qemu_co_mutex_unlock(&s->lock);
> > +        error_report("Failed to %s WP slot (zone %d): %s",
> > +                     is_write ? "write" : "read", index, strerror(-ret=
));
> > +        return ret;
> > +    }
> > +
> > +    slot =3D (uint64_t *)((char *)cluster_buf + off_in_cluster);
> > +    if (is_write) {
> > +        *slot =3D *wp;
>
> Missing cpu_to_be64()?
>
> > +        qcow2_cache_entry_mark_dirty(s->wp_cache, cluster_buf);
> > +    } else {
> > +        *wp =3D *slot;
>
> Missing be64_to_cpu()?
>
> > +static inline int coroutine_fn GRAPH_RDLOCK
> > +qcow2_refresh_zonedmeta(BlockDriverState *bs)
> > +{
> > +    int ret;
> > +    BDRVQcow2State *s =3D bs->opaque;
> > +    uint64_t wps_size =3D s->zoned_header.nr_zones * sizeof(uint64_t);
> > +    g_autofree uint64_t *temp =3D NULL;
> > +
> > +    temp =3D g_new(uint64_t, s->zoned_header.nr_zones);
> > +    ret =3D bdrv_pread(bs->file, s->zoned_header.zonedmeta_offset,
> > +                     wps_size, temp, 0);
> > +    if (ret < 0) {
> > +        error_report("Cannot read metadata");
> > +        return ret;
> > +    }
> > +
> > +    memcpy(bs->wps->wp, temp, wps_size);
>
> Missing be64_to_cpu()?
>
> bs->wps->wp[] is in QEMU's format while temp is in qcow2's format. The
> representations are not guaranteed to remain the same. An explicit
> conversion from qcow2's representation to QEMU's representation would be
> best. You could also use build-time assertions (QEMU_BUILD_BUG_ON()) to
> check that the qcow2 constants match the QEMU constants.

Another idea is making the wps for qcow2 follow the same format as the
block layer's. If there are more bits of a write pointer used, changes
can be performed on the qemu's representation.

>
> > @@ -559,8 +874,34 @@ qcow2_read_extensions(BlockDriverState *bs, uint64=
_t start_offset,
> >                             "is wrong");
> >                  return -EINVAL;
> >              }
> > -            if (!qcow2_check_zone_options(&zoned_ext, errp)) {
> > -                return -EINVAL;
> > +
> > +            bs->wps =3D g_malloc(sizeof(BlockZoneWps)
> > +                + s->zoned_header.nr_zones * sizeof(uint64_t));
> > +            ret =3D qcow2_refresh_zonedmeta(bs);
>
> Is bs->wps freed when qcow2_refresh_zonedmeta() fails?
> > @@ -4161,6 +4879,45 @@ qcow2_co_create(BlockdevCreateOptions *create_op=
tions, Error **errp)
> >              ret =3D -EINVAL;
> >              goto unlock;
> >          }
> > +
> > +        uint32_t nrz =3D s->zoned_header.nr_zones;
> > +        zoned_meta_size =3D  sizeof(uint64_t) * nrz;
> > +        g_autofree uint64_t *meta =3D NULL;
> > +        meta =3D g_new0(uint64_t, nrz);
> > +
> > +        for (i =3D 0; i < s->zoned_header.conventional_zones; ++i) {
> > +            meta[i] =3D i * s->zoned_header.zone_size;
> > +            meta[i] |=3D 1ULL << 59;
> > +        }
> > +
> > +        for (; i < nrz; ++i) {
> > +            meta[i] =3D i * s->zoned_header.zone_size;
> > +        }
>
> Missing cpu_to_be64()?

