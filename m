Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBA5CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 19:08:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6w08-0001FY-Rp; Thu, 09 Oct 2025 15:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6w07-0001Ew-7O
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:08:31 -0400
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6w05-0007JC-7G
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:08:30 -0400
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-42f6e0bdcf7so10451685ab.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 12:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760036907; x=1760641707; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B4aKrhybkNUZSFbfa/ql8Qx4iUIqSmaBTPli/nnEo/Y=;
 b=P3WpqSHK7UTnrYfOHNsLXVZDmcQ8gle6x35a2n7UIHNQ06sciQrkN7xchfeZm/bfKQ
 dGfjWvdcB+9iJGVB35Pb6m/Ysn2wYLlobw58xGkvhnbwl9LXIcz4q2ztS538BOHwhJOq
 pwXpeGXnAC+1muNvRxASVSjE9QDzaT/jhxrjw4Qbxr5d/B25MKkLXY619sGGBgm03mi9
 7/f3ZdREbcWYB9Fx7i7b+UdtSP5QbWFM4ZQeU/HkBwbKwbCBdWj3iX+b4rO5/FBE0LZL
 PzGj+bOwjKW2E04TqZRUyfU2FNHORunLeEDNUR/b79Y/U0cnUG9Z40z2Iya5etJnaC/m
 4q+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760036907; x=1760641707;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B4aKrhybkNUZSFbfa/ql8Qx4iUIqSmaBTPli/nnEo/Y=;
 b=BJCTxirAYxv8Mrcqtif8E0PR+JUX5wBRXgKnlySCyBOZl7TYg5rqAWkZjE1T97IC1s
 5jyYgNB77gm91cq19pku9dWelRVNFkQItgxhCFTn+eynnbcRrXK4j1BqZVvlXQZjO5WA
 IQHPSyITz4hgZEHi/Aqrmm1jwpwH9oHQ+DTdkcZamwZEWiWYGDRxBnkjvnni5S8BSCLp
 vSkh5qg2+ZaWw46J79O9uunmguhUCQCuyMBhK2tdS7DzMCASpiLdtqbv2+TMh51qpyEp
 IGLOca4oRqo7rw74egNZav4xJ89poaUUPVa5sNe8Fl7662fgeHu5LbxWXbR1Vdsho1Pz
 bKQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGZAhS9Jy75EEXrQcWOnRvjgADcea6xHOZh4GHmei/xw3LYXQgxtlMLHlGMQVQENoqLSCWyxAY/0of@nongnu.org
X-Gm-Message-State: AOJu0Yx4ssErvF4rmCmU7Qon8DqFKo+F4A+UJazJLjO6a9mNXLbRjLMv
 tzeUvahqo+rteT7edEYT9N2EhKqzWRrJ2Ba0Zd/JESfUpdSYTnZh8xPYt4XP9SVd/F7hVi8ph0Y
 l8sBhE+TAiSBrPgqdLKdH5fKmg3wN1F4=
X-Gm-Gg: ASbGncty0OmXJz2xiYfL5MO8ZxbaMbFdXkpcGBurO9KHLCzJhUvc2+pPsOkXNzA7zrC
 XzmAu7WL7O55zul9Dw3PqRKA5OxF7EcGUBTdOhAxvpRrueIXY8LvuawRT4viw48T+wP8zFRuDch
 NCrqtaAYSUx13Ydqtb5auRvfTCrBdotZJ09hj/nny2Cs9EkC4Wj+Qo4G5pKZXKK9gSiCgSrQZQL
 wdQsrfOd9Q+7M/xq76KvxMy9g6BH1UFKBxJcRX0CQ==
X-Google-Smtp-Source: AGHT+IFenRA5i+XYQg79d7gJJLA2AOFLizmdrXdS1s337i0Ux3dKi/slzkZRoSNWzrgUwiPgrAnLYd7w/RhiKJzFUco=
X-Received: by 2002:a92:c241:0:b0:424:85b0:e1cb with SMTP id
 e9e14a558f8ab-42f8740330amr89660965ab.31.1760036907291; Thu, 09 Oct 2025
 12:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-24-vsementsov@yandex-team.ru>
In-Reply-To: <20250813164856.950363-24-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 9 Oct 2025 15:08:16 -0400
X-Gm-Features: AS18NWBSYY01bSRIBRc7CSCce_QFBRIkAXJBKpTVTXxkck18yNWAh5mKdoRCuzc
Message-ID: <CAFubqFu+CPGKO_-wLLqXQaO5wLr2R6gykZ2ufrC0aHqjebVAmA@mail.gmail.com>
Subject: Re: [PATCH 23/33] vhost: add some useful trace-points
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net, 
 sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::12b;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x12b.google.com
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

On Wed, Aug 13, 2025 at 12:58=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/trace-events |  8 ++++++++
>  hw/virtio/vhost.c      | 16 ++++++++++++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index e5142c27f9..bd595fcd91 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -10,7 +10,15 @@ vhost_reject_section(const char *name, int d) "%s:%d"
>  vhost_iotlb_miss(void *dev, int step) "%p step %d"
>  vhost_dev_cleanup(void *dev) "%p"
>  vhost_dev_start(void *dev, const char *name, bool vrings) "%p:%s vrings:=
%d"
> +vhost_dev_start_finish(const char *name) "%s"
>  vhost_dev_stop(void *dev, const char *name, bool vrings) "%p:%s vrings:%=
d"
> +vhost_dev_stop_finish(const char *name) "%s"
> +vhost_virtque_start(const char *name, int idx) "%s %d"
> +vhost_virtque_start_finish(const char *name, int idx) "%s %d"
> +vhost_virtque_stop(const char *name, int idx) "%s %d"
> +vhost_virtque_stop_finish(const char *name, int idx) "%s %d"
> +vhost_dev_init(void) ""
> +vhost_dev_init_finish(void) ""

Ditto here - I would think this should also have the VirtIODevice/vdev poin=
ter.


>
>
>  # vhost-user.c
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index e796ad347d..e7c809400b 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1329,6 +1329,8 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>      };
>      struct VirtQueue *vvq =3D virtio_get_queue(vdev, idx);
>
> +    trace_vhost_virtque_start(vdev->name, idx);
> +
>      r =3D vhost_vrings_map(dev, vdev, vq, idx);
>      if (r <=3D 0) {
>          return r;
> @@ -1390,6 +1392,8 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>          }
>      }
>
> +    trace_vhost_virtque_start_finish(vdev->name, idx);
> +
>      return 0;
>
>  fail:
> @@ -1408,6 +1412,8 @@ static int do_vhost_virtqueue_stop(struct vhost_dev=
 *dev,
>      };
>      int r =3D 0;
>
> +    trace_vhost_virtque_stop(vdev->name, idx);
> +
>      if (virtio_queue_get_desc_addr(vdev, idx) =3D=3D 0) {
>          /* Don't stop the virtqueue which might have not been started */
>          return 0;
> @@ -1441,6 +1447,8 @@ static int do_vhost_virtqueue_stop(struct vhost_dev=
 *dev,
>      }
>
>      vhost_vrings_unmap(dev, vq, true);
> +
> +    trace_vhost_virtque_stop_finish(vdev->name, idx);
>      return r;
>  }
>
> @@ -1598,6 +1606,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *op=
aque,
>  {
>      int i, r, n_initialized_vqs =3D 0;
>
> +    trace_vhost_dev_init();
> +
>      hdev->vdev =3D NULL;
>      hdev->migration_blocker =3D NULL;
>
> @@ -1682,6 +1692,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *op=
aque,
>          goto fail;
>      }
>
> +    trace_vhost_dev_init_finish();
> +
>      return 0;
>
>  fail:
> @@ -2132,6 +2144,8 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIOD=
evice *vdev, bool vrings)
>          }
>      }
>      vhost_start_config_intr(hdev);
> +
> +    trace_vhost_dev_start_finish(vdev->name);
>      return 0;
>  fail_iotlb:
>      if (vhost_dev_has_iommu(hdev) &&
> @@ -2210,6 +2224,8 @@ static int do_vhost_dev_stop(struct vhost_dev *hdev=
, VirtIODevice *vdev,
>      hdev->started =3D false;
>      vdev->vhost_started =3D false;
>      hdev->vdev =3D NULL;
> +
> +    trace_vhost_dev_stop_finish(vdev->name);
>      return rc;
>  }
>
> --
> 2.48.1
>
>

