Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C641DC98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 19:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Ska-0002BD-DO; Wed, 23 Sep 2026 15:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x9SkY-0002Az-LA
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 15:35:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x9SkX-0007Xq-AN
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 15:35:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790192124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3aYdA549TNlaOOcBA7l/ow6qYaT62YUcLnPjiorub8g=;
 b=R48JPBw/Jfrm0kI01lOmNBaZIYQKRfUUlsUEZ/fkG1in5jQ8zL7a85G+VtjQ1LZwar8Iee
 z5pYUHHXy71LHs0kh6PjpOq87raQg1BLg1pnAXKRn28elvOWeQmJ5D1iaJEoNW3fqHM+Gd
 XnvSj0LwWVhj84XA2Z0TKKyZlO397a8=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-SN0RkbtQOv2z7Cvz7PweAg-1; Wed, 23 Sep 2026 15:35:20 -0400
X-MC-Unique: SN0RkbtQOv2z7Cvz7PweAg-1
X-Mimecast-MFC-AGG-ID: SN0RkbtQOv2z7Cvz7PweAg_1790192120
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-67156f9bad0so1624135d50.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 12:35:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790192120; cv=none;
 d=google.com; s=arc-20260327;
 b=kb28mlzHlnyH+SiSzxOfWLndV7Id4IgAT70HcaVLUQzVnrwrSktl3o27YfpkRvIxT6
 9fNSJPVS2z2m4T/7EP8CjisMEh7hb8s6VSqK2LS26MAptB8v1hCwkPds2t+6f2NQBa2n
 INX+DsB4YZi+NVIX0iE+1UVddyvirc0QjdMjHNc9HZ2BlE1GBtUH7XwI0vPcmA4Nr+JT
 4gtx+MXsf92cWOFdSLXcJyPGy7v9IJ6qyIZOH8xHb22LavkNP702ja7ou9xwolS/rKj+
 5+PHAlglmgkM+ErbyiFjpOXWxObiEqQO2LFzAP2b9Z5gfeHMfGXZWXBRQldizgb4q1rC
 cs6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3aYdA549TNlaOOcBA7l/ow6qYaT62YUcLnPjiorub8g=;
 fh=b0Z3lWGcCo1hESi6SCJ0YxnP/BPVR7A0V6Qykw4FH5U=;
 b=sww+F0p8F79lUDlBi4nvLZXj2SGS0Lh82ZRXjzfjgsl7BE+JBsw64bGSzLTjYCOLdw
 6/Rn/pH/a9h2LrE10/bQDl378mo1zvRkxpOGYFqcpegC45CHKebTGN2GnOCbjubNlkNF
 EtNjZZPmZr4QxbVJSWSh6+WZyJKPG27NHhH/RFBo7ZvDko8FwOYaz5WoYXDNaYBZZLk+
 hmKfqs3JYiW2uRkra133pj3hpPjS9gE+5j0nZP6DMSyyMJWSNO7LVY+dexqBN32R3v4B
 a+OB/m0hMd09LCS2He1IHxNreKz+QoSSAeLLoWwepAACLKZxYofeOX4/2HlPzn2tQsyV
 0mcw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790192120; x=1790796920; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3aYdA549TNlaOOcBA7l/ow6qYaT62YUcLnPjiorub8g=;
 b=spnm18vqa2r5+63G2p3v4kMNVLwKVaFKLyH8JHPnsVDLH/bLqagg0d0fov4T3XIP8d
 AUxvK8vv5L8QR2KmT3XjfakfFRR9JfsSKMeI9gf2PvYWjHCUA1kIe7K3fH3a59wqa5ab
 scf7d9dhQQEbZjopwC4UyKM/vbEXHj5FFk6CZ3GG16/tTU/mzw5lgiPj2O91lD3hYuUP
 DyvIonm6JSar8RI8+hn62TljDT5WVxeENj0NBhHbbUa0I/eMMLnfXtn4/x17GIlhpoxD
 MGbPlnNi0Vrf3DabG68mgQJR041K5UxgvmhS5bRf64/BH8QGXk3mzsVDS06JwwEmOpWp
 CBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790192120; x=1790796920;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3aYdA549TNlaOOcBA7l/ow6qYaT62YUcLnPjiorub8g=;
 b=FRGm3ZnOjLkeZZeaNNZ+XgyYUJ+5zWgQtrbCoJkXODmc1VN8CRoKmmG7UOXM2ifytY
 cXyJLASf9qL+fW08ZzPckzpYj/GVzjTMdo7JKjd/bJ1x6rMDaSMT1s4KMI+c2gtlOP0f
 ntyF8zlhrRANzjTHCxGv/QdN7KsAx2AKeg7gnt5/fg/FZFLtgIkr6WIXAQVSTO7Og8ke
 Z5jvndOyRi4RGMVRXDXKIM9iAfw09kqOFsrtasjdzVhYwbaQWsms7sWCp/zxae9QIclm
 xomBOm+eDUVqn80gcvEGchOEqsIXqwc6lWihM0S13iQ8IbLpoY/FpRtaPqdAAU/AroND
 zDxw==
X-Gm-Message-State: AFuF++moHAGLhaVy83XrVpjLXFht2PlYW/8aB8otWOfZ/fA/P1EdxkQ/
 hNn7T+KV/f+qCgtsz5bBoC7Jtcca6K3uipDx/LNlF9AFOxjhZ1CzwSOS1/uFASMDNPAOvyrwDCs
 fE+FOXsFDcly2rczcstOYp5PY2DSC8Tvsd/v8AOHmo+Hvs8FfiTcJtV+JXZZsVxUCp8lkfsLHI8
 gSzWgM9e2QdGRo+EAWLOEYoioJmRKSD1s=
X-Gm-Gg: AYBFou0tXeBWpDB28ool10EKXMTENZ97/mnQlGQMjLDHSYbhA3JLE0BRMDKxSSf5moI
 zQyF77WBk4dPgslYntDAT2UhP8h5a3I5Q5gXS/VkSD6NeKqo4v1eTHb5WFXGJLF2GGuNfBBVARl
 qPpc70YjkBz2mGGNZ3znjHfY3evL8RXPgwCjvSWndWK+YrliciN23JwE8tttbxgEkwy7bYxvHgn
 uRJliKqH7Qevd00
X-Received: by 2002:a05:690e:b83:b0:66e:54a0:cdca with SMTP id
 956f58d0204a3-672ed3b2f75mr175175d50.49.1790192120235; 
 Wed, 23 Sep 2026 12:35:20 -0700 (PDT)
X-Received: by 2002:a05:690e:b83:b0:66e:54a0:cdca with SMTP id
 956f58d0204a3-672ed3b2f75mr175153d50.49.1790192119773; Wed, 23 Sep 2026
 12:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260921205712.1862167-1-jsnow@redhat.com>
 <20260921205712.1862167-5-jsnow@redhat.com>
 <8733v0wchg.fsf@pond.sub.org>
In-Reply-To: <8733v0wchg.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 23 Sep 2026 15:35:08 -0400
X-Gm-Features: AcwNN1Wr7rGQAPJ3Yenh4qA3hkyZd8LMMh_nJ-xzyxoIM6yRtDiCnhIuPf6_N3w
Message-ID: <CAFn=p-ZFsNZfGvRoYiV2GXRUninwyxgyjkNF8A8DwtBc8LQVnQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] qapi: convert/split intros for job.json commands
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Jason Wang <jasowangio@gmail.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Sep 23, 2026 at 5:20=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> Consider mentioning how this affects rendered documentation: first
> paragraph of job-dismiss splits.

ACK


