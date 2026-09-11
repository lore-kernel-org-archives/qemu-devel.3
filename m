Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4B1C88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 18:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x567e-0003e4-N6; Fri, 11 Sep 2026 14:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <admin@fluentlogic.org>)
 id 1x52af-0002lL-L1
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:50:59 -0400
Received: from mail-06.mail-europe.com ([85.9.210.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <admin@fluentlogic.org>)
 id 1x52aZ-000311-Ab
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:50:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluentlogic.org;
 s=protonmail; t=1789138230; x=1789397430;
 bh=De0REzMfukUbEXHjolkFnu1mZfjNv5h/UUnnlW1DL6I=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=sweMvPcXx+MNDS2dqPLWPgXAavHzZRLoNzh00UqCaXyGPZ/P8nBXgm/hLOU/upn4R
 Se4il6WOnOl4bR6Kl2ZTnyaBJI1RiYgY+I++OgZlQcCAUUus42pSt7rdQ1Vz/TkmK1
 UWp2eqA5M8rEiq9eSP1TmB5c3Mb7UJuUPI217mVxwofzWo0cZs2Bl8dxK+KyIz18fy
 ck+ttnQbj11IW5aOLMU6ozg24JFIsxuxvcLlPlyoz9CURJ9PIB06l5Cf62tQSI3Rnt
 LTMKxVET5rE1E/6SU5oaXvK0cLXvmFG370EJVdw5DmhCcxkf1hAQRGHcPb0PuQ29K6
 cvGpyUH/dHg5A==
Date: Fri, 11 Sep 2026 14:50:27 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
From: admin <admin@fluentlogic.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PULL 35/90] vhost-user-gpu: validate command buffer size in
 submit_3d
Message-ID: <vS_zoq7xV72MBuvqs7PZm6l_gTHRVAaWE0Ov2cMINLQ0eZVkyR4gm7QPVITUA8_57brkn2CoVCUii7jfgDufyBM1JcrZs1WPFLiYfKoR-bs=@fluentlogic.org>
In-Reply-To: <67f10fb88d3c75da3ba7fa5a37f7d6bcfcf3ce9e.1789071042.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
 <67f10fb88d3c75da3ba7fa5a37f7d6bcfcf3ce9e.1789071042.git.mst@redhat.com>
Feedback-ID: 121058281:user:proton
X-Pm-Message-ID: 07dc168129f7288b8c816346bf665dd8ec24a1d4
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=85.9.210.45; envelope-from=admin@fluentlogic.org;
 helo=mail-06.mail-europe.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 11 Sep 2026 14:37:05 -0400
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

Thanks Michael for the review. Merci Marc-Andr=C3=A9!=20
Let me know if I can support in any ways shape or form in other such work.=
=20
Best,
Martin Brodeur




On Thursday, September 10th, 2026 at 4:13 PM, Michael S. Tsirkin <mst@redha=
t.com> wrote:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> virgl_cmd_submit_3d() passes the guest-controlled cs.size directly to
> g_malloc() without any bounds check. A malicious guest can set this
> field to an arbitrarily large value (up to 4GB), causing an OOM abort
> that crashes the vhost-user-gpu daemon.
>=20
> Validate cs.size against the actual descriptor payload size before
> allocating, rejecting values that exceed what the virtqueue entry
> can carry.
>=20
> Fixes: d52c454aadc ("contrib: add vhost-user-gpu")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3776
> Reported-by: admin@fluentlogic.org
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Message-ID: <20260713125431.107278-1-marcandre.lureau@redhat.com>
> ---
>  contrib/vhost-user-gpu/virgl.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/contrib/vhost-user-gpu/virgl.c b/contrib/vhost-user-gpu/virg=
l.c
> index 20bae57d0f..c95c4afc5c 100644
> --- a/contrib/vhost-user-gpu/virgl.c
> +++ b/contrib/vhost-user-gpu/virgl.c
> @@ -197,20 +197,24 @@ virgl_cmd_submit_3d(VuGpu *g,
>                      struct virtio_gpu_ctrl_command *cmd)
>  {
>      struct virtio_gpu_cmd_submit cs;
> +    size_t iov_len;
>      void *buf;
>      size_t s;
>=20
>      VUGPU_FILL_CMD(cs);
>=20
> -    if (cs.size > VIRTIO_GPU_MAX_CMD_SUBMIT_SIZE) {
> -        g_critical("%s: command buffer too large (%u)",
> -                   __func__, cs.size);
> +    iov_len =3D iov_size(cmd->elem.out_sg, cmd->elem.out_num);
> +    if (cs.size =3D=3D 0 || iov_len < sizeof(cs) ||
> +        cs.size > iov_len - sizeof(cs) ||
> +        cs.size > VIRTIO_GPU_MAX_CMD_SUBMIT_SIZE) {
> +        g_critical("%s: size out of range (%u/%zu)",
> +                   __func__, cs.size, iov_len);
>          cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
>          return;
>      }
>=20
>      buf =3D g_try_malloc(cs.size);
> -    if (!buf && cs.size) {
> +    if (!buf) {
>          cmd->error =3D VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
>          return;
>      }
> --
> MST
>=20
> 

