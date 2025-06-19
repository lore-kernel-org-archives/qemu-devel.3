Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EEFC7115D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 18:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSKR8-0000tp-Ck; Thu, 19 Jun 2025 14:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <idryomov@gmail.com>)
 id 1uSKR2-0000t4-Ah; Thu, 19 Jun 2025 14:56:28 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <idryomov@gmail.com>)
 id 1uSKQz-0000ze-5J; Thu, 19 Jun 2025 14:56:26 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b2c2c762a89so887572a12.0; 
 Thu, 19 Jun 2025 11:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750359383; x=1750964183; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X59hpwk1j0gAf9yfSf4iakytT6iYx4Uu2zET67ei1T8=;
 b=FJ5fCO7eFya1sGCMNX0Csb8b/VEaqG6NGV6xeceH/pvga3DXa3B1x13KdaHCv5XTEE
 svfFzyHNqptOChJY2co7gg9y0KAuKVVXXgy+8NJxfh8QxMEnqnMc7qVf6S4wFi87/OlN
 36NCer+4XW1u66QpmqQVdS5QJQQ0miSeZmEM3VrUvIgXrPdSLzUU5mjPns5i7W/nFNFY
 bVv0AuzDfrmRki0dkq0hqwsuMooeExiZ9V17vTd8vt4qg9YudE6VDZlgWXZECoEOYQ6x
 AIZZHbJK8vZYuxG0fHTgSoYeGQGlejCQd4pxL3PzWV+NiY7FdhL1TgugBz6GZLliJBBs
 kL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750359383; x=1750964183;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X59hpwk1j0gAf9yfSf4iakytT6iYx4Uu2zET67ei1T8=;
 b=HWQB9Z/eLlosJ58vcSohMS0Tns3nRe5H4SHOqAjbigoT9Z6oZ4wrtebJLA3gahb1zT
 zbE634c2Ri6n0DBZG75QeqeeScZUpl9MyfwiSCKBkiMg6i+fIGCpKy7WTC2uRMw9Tsm+
 3W3TQQJ7OreH1pUsH3TMy153ku+dufAZG56RBdnH7pMjCP5Os8h7+soqL54yp5HZs4yb
 PUyuMKBg9BywkPeGpyyc/AQ0syNPAZZsbyP2l1RRX6SOTrojJgWtodPT/9VkaEZH65M5
 OTkT+TrjYqHhaxndyfydjI3XXTpZS2vaDwb1uMIrFsMP2AQfERrN/p7wpVzc5C+Zx6ER
 l6bA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKIWUInTacBSDDOpIYUxDtEzgC+DJQWzVion70oJjA6tNSmTxGQyo3vQF4+vzgHH7xeHdmCJg3Ennl@nongnu.org
X-Gm-Message-State: AOJu0YzboydHJzmmjHlbMLD/0ySKn9BKhGysdtMGPl3ErO4H8EhC/jky
 O4d0y+hvoo3vlhy2f94NWE9l+ug+RjGG+F9oU3TC9aocxkFeeTCv9me4swWZKQIbjPwYvcAPwSQ
 vu2MFlOBEd35MPgo71bXBO/UHVfwhluk=
X-Gm-Gg: ASbGncuTebg7EgUbwkhJAb4AbjvqFqVozp+8NCwLQD1T3oTWD6qoAYXDNkZemrd3U4z
 SZX//jCAqt/1dqRLO3hoLjDqCtT082unvogtljaD2ArjB3zAKiTAKVuhpsRqfvhVYyFs/T8JBm5
 uWmsRx8DzIp7aQSiAqg1glqwtv7IMBSpNDiNurzsCesow=
X-Google-Smtp-Source: AGHT+IHlSDu5HoESr7xH/s08EG5P/AKDOMOo2aCm4x7aMRQnOOc4qCvTLzw7VwNfYDhDYcEe7ES0bxkExeK38gxB/Gg=
X-Received: by 2002:a17:90b:3d85:b0:301:9f62:a944 with SMTP id
 98e67ed59e1d1-3159d8ff798mr472309a91.33.1750359383191; Thu, 19 Jun 2025
 11:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250515112908.383693-1-f.ebner@proxmox.com>
 <20250515112908.383693-3-f.ebner@proxmox.com>
 <CAOi1vP_kEY31-brzTfG6K9y0Wbv06e=9vH=rqD9ouwq32VaYAA@mail.gmail.com>
 <b0f1ebc4-c7fd-45f9-aa99-a9507c1df55f@proxmox.com>
In-Reply-To: <b0f1ebc4-c7fd-45f9-aa99-a9507c1df55f@proxmox.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Thu, 19 Jun 2025 20:56:11 +0200
X-Gm-Features: AX0GCFtoGX5yQWGmCADY88bGL37E1UAk5HHLXLplYARQHGa-7QoyS64uUD9vxDg
Message-ID: <CAOi1vP8y0nFZU-uOCy0sUBBgBUZX3ZdMA0dLKX1s0dXc3oKePQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] block/rbd: support keyring option via QAPI
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com, 
 eblake@redhat.com, hreitz@redhat.com, kwolf@redhat.com, pl@dlhnet.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=idryomov@gmail.com; helo=mail-pg1-x531.google.com
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

On Mon, Jun 16, 2025 at 2:51=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.com> w=
rote:
>
> Am 16.06.25 um 11:34 schrieb Ilya Dryomov:
> > On Thu, May 15, 2025 at 1:29=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.co=
m> wrote:
> >>
> >> In Proxmox VE, it is not always required to have a dedicated Ceph
> >> configuration file, and using the 'key-secret' QAPI option would
> >> require obtaining a key from the keyring first. The keyring location
> >> is readily available however, so having support for the 'keyring'
> >> configuration option is most convenient.
> >
> > Would such a setup have a ceph.conf file that is shared between
> > multiple users (or no ceph.conf file at all if the monitors are
> > specified via QAPI option) but individual keyring files for each
> > user?
>
> There is only a single Ceph user and we could create a ceph.conf file
> with the 'keyring' option set. It was just not required in the past,
> because we specified 'keyring' via '-drive' directly, so having this
> option would be more convenient for us.
>
> In short: we can still make it work on our side if there is no interest
> in adding this option in the QAPI.

I don't have a strong opinion, but it feels a bit like circumventing
the QAPI secret infrastructure.  It's already possible to circumvent it
indirectly through the keyring option in ceph.conf file but that is
something that falls out naturally and has always been there.  Adding
a more direct way to do it has me split...

Thanks,

                Ilya

