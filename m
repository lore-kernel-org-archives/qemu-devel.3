Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C100C5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 11:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsIW8-0003Hd-Kr; Fri, 07 Aug 2026 07:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wsIW6-0003H2-Ro
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 07:13:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wsIW5-0007yh-7Y
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 07:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786101212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rZv49udu4GsND6TVpqaF+ekjj3al4aQGDmjQWE+RvCw=;
 b=gUUv1P8AnuMcxAgq2FE2PMj81Nllcwjak6PPKUFWkQy2O1JlHQwYB5WnAN7T8FRMH6pT12
 HP8MD9GRZ6sXOCKZFkkCv34L5o/AtRNgmWQHbZ+1Kst/E88FfLHmPKO5FeCwDNs94qisoN
 K2nbYoroLOO/2pCYxCvRRvdWizEo9pA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-IiK4S23BMdehFG1TR5706Q-1; Fri,
 07 Aug 2026 07:13:29 -0400
X-MC-Unique: IiK4S23BMdehFG1TR5706Q-1
X-Mimecast-MFC-AGG-ID: IiK4S23BMdehFG1TR5706Q_1786101208
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 696831800614; Fri,  7 Aug 2026 11:13:27 +0000 (UTC)
Received: from localhost (unknown [10.47.238.100])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B645D1800346; Fri,  7 Aug 2026 11:13:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/3] hw/display/virtio-gpu: Avoid creating empty
 udmabuf
From: marcandre.lureau@redhat.com
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
In-Reply-To: <20260807-dmabuf-v1-1-d24b1331dc8a@rsg.ci.i.u-tokyo.ac.jp>
References: <20260807-dmabuf-v1-0-d24b1331dc8a@rsg.ci.i.u-tokyo.ac.jp>
 <20260807-dmabuf-v1-1-d24b1331dc8a@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 07 Aug 2026 15:13:15 +0400
Message-Id: <178610119592.1593099.7285108293579463800.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1875;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mxD0Kfeh5h9N8g/fLzSy8zcI8IsisB+iY3HOxVzJX0k=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqdb3Nu7Exe9KzImIzgkQfRQ6BQM5hNUUhr4xbA
 0IrD/4t/BKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanW9zQAKCRDa6OEJdZac
 5SejD/9dY24yEgWULJ/XRbj7H2Y7pgirsfdlipfhw++EM49ZWarqes5c5tujVa3ljRqO01Z4A/V
 u/IEpm17Sr+pa5bqXr/6+kZQXQNn9/y3CpN0Sq/TlVwofXaxBMzlAZNIQZZQzhdf7AhCmcimjpv
 l+jM4PN5Jr9SIljb1SXpDfqjltKqX8/jYZQmuGLKV5bRTrB3VDCns0el6vCo5I18/bP30snEjnr
 RT0EHVrJfWMMOsZJv9YO76POH+BZHWy3kJ+MPiYOSLno2nmosdtf7E4uhx34bXloffVJ+iQoMBU
 6/7V5DCW2HNS3vi0b42UOJqZn0f5HyLj4zZqeYet6a0/vHdpB2wdsKdl+Elx3lMDdJu2Je9WEtA
 vx+fAfsiRMZGwyuipQ/wt1mkDcS4tQnB8FlQ1YnfAsggd0nv5Sz3bsO0pZpmLhJ3/8LbKPQ1KjD
 41Aeo5Q0EhggvjQUCQrsJ3g2RB8g2Nwtx0ChJQy6smT0QWDJkccWymkjet3RqxwD/5/qV9I2Pgz
 BHjN/hqSUrHSpuDlezU0q9WNYABz1s80CRC1cHgwihd8JIJlO3E2zMtIbPyoxZe2XLphKT6vZtb
 KmMi0ieMbMbvhe5ze6nPCVWMdYEzSF+sLMe7eAAglzKdncmcBoQcnJrLaQ84HLOMDG841GNFPN7
 rQ7n5343AFAYGsg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

> The virtio specification allows creating a blob without backing storage
> attached. However, virtio-gpu attempts to create an empty udmabuf for
> such a blob. The ioctl fails with EINVAL and emits a spurious warning.
> Avoid the invalid ioctl.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Message-ID: <20260807-dmabuf-v1-1-d24b1331dc8a@rsg.ci.i.u-tokyo.ac.jp>
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index fbb6fec7a0ad..6bd87d900170 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -363,27 +363,29 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
>      res->resource_id = cblob.resource_id;
>      res->blob_size = cblob.size;
>  
> -    ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
> -                                        cmd, &res->addrs, &res->iov,
> -                                        &res->iov_cnt);
> -    if (ret < 0) {
> -        cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
> -        g_free(res);
> -        return;
> +    if (cblob.nr_entries) {
> +        ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
> +                                            cmd, &res->addrs, &res->iov,
> +                                            &res->iov_cnt);
> +        if (ret < 0) {
> +            cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
> +            g_free(res);
> +            return;
> +        }
> +
> +        if (iov_size(res->iov, res->iov_cnt) < res->blob_size) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                        "%s: backing storage smaller than blob size\n",
> +                        __func__);

Continuation lines are two spaces short of aligning after the opening
paren of qemu_log_mask().

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


