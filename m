Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128A4D3B7E2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 13:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSbhV-0004yt-Hk; Mon, 08 Dec 2025 08:54:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vSbhT-0004y5-E6
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 08:54:51 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vSbhR-0000q2-Mg
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 08:54:51 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42b38de7940so2307749f8f.3
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 05:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765202085; x=1765806885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ghfy1jzjJy3z8b9j0cjjW5BUXrmkCH6bR5lmrcAjsYg=;
 b=RSo4nQQidW7WWKK7iHHOkhAG4B71LkcEzF4MY6lCpfIdexEVgoKuZwvu6RHZVm4wxK
 ZYuH24hhJTV2HQctpOfEqUUrvTQFtzBAoEJSGlA/CYyJoZj80ZBDnxz9zGogEw/qM8ON
 eRIViyBBjuChJ9fPJ1FDizb46BlgTfk3H9T327jstaYrpNBcZ14rLeqRsppgmCpG/C77
 55xUVJS8lmm3W0JHy0Wp0/nU4uWXopmWG3EYIIaiqUYKpYW0FL3F+WzLun6R9bMXEVrL
 ZF3N+lXknfTKav4ZpyZ2yYb2ayos8vhoW+RlnmqUi1uhpFGIoxMpeVVJhhC94rfFoM8f
 RRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765202085; x=1765806885;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ghfy1jzjJy3z8b9j0cjjW5BUXrmkCH6bR5lmrcAjsYg=;
 b=asxJhrOfuXeYEsNliLzgqB74jBUDhU/Wt5E5iZFRGnLKEQlgYT+Kr7d/e/JY6ErW1l
 9tbJpOMewIiROf2phs7vGynRArbiCWoE9CvOnQOvfLCgcUWy3UG4pcNKt83ntGBvCJjI
 mZpzyRnHCi/1u1RRjoA/EcjkgcQO1tvT0PTAsF/AChZysj8nizF+2QINA5IR90q+T7pF
 hQ1IPJgfTpTV/0mUnTq+uokeeSLfiWglXy1TdSfaul17RRCT2eDKyVuMXutMl/Trrej5
 oTvx9FtyszlVL0LyhJ2dyqRcO56sibfnsc/GfhP+nXtyXyQGNqE+DqVUq6mdYgqa3j6X
 pmCQ==
X-Gm-Message-State: AOJu0Yxs3+ws7znRX+XdHtTAG/JTOFcEdcuEiu28kh3bwp1WBfms+KKK
 BySGGhZOyy+dhw1CzOlyfHd4XvW7GY6+e0ChFqAnM6b2mkHo0cFh2NRfkS+t3y4CV7A=
X-Gm-Gg: ASbGncshkZbbiJZQSDbZcQQY7sLJtANQr/JAT9NpGLTLBtWZeanAD9mulkNphYX0+Ix
 yDH+07NTCZsOYWLXxOdZYP3Y6O+PbtBwnIToRvra+BzpzzSnuNQ73bb3mLFa2fOUdkaWuRTVycJ
 DU2+w2KVgbLEP2Mq00qbszrPQNSbnPtcLbxtTZuWTBJE2PsUALBAw0WAMIv6mQTpOknPGSeCdZk
 9F0uLcDxzYoyZQ/EEIL76E8/OHOUNHDiMm7/a0/rzXRWep+vzayYMirtM3hv7wqHXgXDnh8NCEZ
 8C3L+DLMtCIkYu5vCnJiWPL2/m8dnTK0I1ikCYmCHwDMnI7F7x/6X/5H+7yQQlWKXCbs1Cy2G1O
 11kNvqtRWUMdcDMdGGl7JUdRHGY5wVvBH1cQmJkTSKk1fyRqIgSGDTih+HiQS+uwOnr8sBToSJw
 d2YQJ+B+E7f0Lc6+V5xXT28Q==
X-Google-Smtp-Source: AGHT+IGiE0qL2djRtWfV7tWonR89014NAL6t99S6TT1i18xkba66UEd8MOwFvt2CvHo9xqOdng07qw==
X-Received: by 2002:a05:6000:4010:b0:429:c14f:5f7d with SMTP id
 ffacd0b85a97d-42f89f47859mr9316359f8f.29.1765202084581; 
 Mon, 08 Dec 2025 05:54:44 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d222478sm25275662f8f.20.2025.12.08.05.54.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Dec 2025 05:54:43 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DD3125F831;
 Mon, 08 Dec 2025 13:54:42 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: qemu-devel@nongnu.org,  "Michael S . Tsirkin" <mst@redhat.com>,  Stefano
 Garzarella <sgarzare@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>,  Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 1/2] virtio-scsi: Make max_target value configurable
In-Reply-To: <dcb4ca40497dd88f27b345c708402885abdad776.1763999544.git.karolina.stolarek@oracle.com>
 (Karolina Stolarek's message of "Tue, 25 Nov 2025 11:01:50 +0000")
References: <cover.1763999544.git.karolina.stolarek@oracle.com>
 <dcb4ca40497dd88f27b345c708402885abdad776.1763999544.git.karolina.stolarek@oracle.com>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Mon, 08 Dec 2025 13:54:42 +0000
Message-ID: <87h5u1hye5.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Karolina Stolarek <karolina.stolarek@oracle.com> writes:

> In virtiscsi_probe(), virtio-scsi enumerates all possible
> targets, up to VIRTIO_SCSI_MAX_TARGET, to see which of them
> are available. This means that during that scan, the initiator
> queues up INQUIRY commands to the targets that do not exist.
> Such inquires fail, returning a BAD_TARGET response.
>
> Currently, there is no way to limit the number of possible
> targets or to finish the scan earlier. Add "max_target"
> option for virtio-scsi and vhost-scsi devices to provide
> a hint on the number of targets available for scanning.
>
> Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
> ---
>  hw/scsi/vhost-scsi.c            |  2 ++
>  hw/scsi/virtio-scsi.c           | 42 +++++++++++++++++++--------------
>  include/hw/virtio/virtio-scsi.h |  1 +
>  3 files changed, 27 insertions(+), 18 deletions(-)
>
> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> index cdf405b0f8..1a4860a72f 100644
> --- a/hw/scsi/vhost-scsi.c
> +++ b/hw/scsi/vhost-scsi.c
> @@ -353,6 +353,8 @@ static const Property vhost_scsi_properties[] =3D {
>                         128),
>      DEFINE_PROP_BOOL("seg_max_adjust", VirtIOSCSICommon, conf.seg_max_ad=
just,
>                        true),
> +    DEFINE_PROP_UINT16("max_target", VirtIOSCSICommon, conf.max_target,
> +                        VIRTIO_SCSI_MAX_TARGET),
>      DEFINE_PROP_UINT32("max_sectors", VirtIOSCSICommon, conf.max_sectors,
>                         0xFFFF),
>      DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSICommon, conf.cmd_per_lun=
, 128),
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index 93e87c459c..091f68090e 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -971,7 +971,7 @@ static void virtio_scsi_get_config(VirtIODevice *vdev,
>      virtio_stl_p(vdev, &scsiconf->sense_size, s->sense_size);
>      virtio_stl_p(vdev, &scsiconf->cdb_size, s->cdb_size);
>      virtio_stw_p(vdev, &scsiconf->max_channel, VIRTIO_SCSI_MAX_CHANNEL);
> -    virtio_stw_p(vdev, &scsiconf->max_target, VIRTIO_SCSI_MAX_TARGET);
> +    virtio_stw_p(vdev, &scsiconf->max_target, s->conf.max_target);
>      virtio_stl_p(vdev, &scsiconf->max_lun, VIRTIO_SCSI_MAX_LUN);
>  }
>=20=20
> @@ -1260,23 +1260,26 @@ static void virtio_scsi_drained_end(SCSIBus *bus)
>      }
>  }
>=20=20
> -static struct SCSIBusInfo virtio_scsi_scsi_info =3D {
> -    .tcq =3D true,
> -    .max_channel =3D VIRTIO_SCSI_MAX_CHANNEL,
> -    .max_target =3D VIRTIO_SCSI_MAX_TARGET,
> -    .max_lun =3D VIRTIO_SCSI_MAX_LUN,

See bellow.

> -
> -    .complete =3D virtio_scsi_command_complete,
> -    .fail =3D virtio_scsi_command_failed,
> -    .cancel =3D virtio_scsi_request_cancelled,
> -    .change =3D virtio_scsi_change,
> -    .parse_cdb =3D virtio_scsi_parse_cdb,
> -    .get_sg_list =3D virtio_scsi_get_sg_list,
> -    .save_request =3D virtio_scsi_save_request,
> -    .load_request =3D virtio_scsi_load_request,
> -    .drained_begin =3D virtio_scsi_drained_begin,
> -    .drained_end =3D virtio_scsi_drained_end,
> -};
> +static struct SCSIBusInfo virtio_scsi_scsi_info;
> +

We can't have a static structure here otherwise all the VirtIO scsi
devices will share the same configuration.

> +static void virtio_scsi_init_scsi_info(struct VirtIOSCSIConf *conf)
> +{
> +    virtio_scsi_scsi_info.tcq =3D true;
> +    virtio_scsi_scsi_info.max_channel =3D VIRTIO_SCSI_MAX_CHANNEL;
> +    virtio_scsi_scsi_info.max_lun =3D VIRTIO_SCSI_MAX_LUN;
> +    virtio_scsi_scsi_info.max_target =3D conf->max_target;

I think we need to allocate a dynamic configuration block for this
stuff. Although given we have ops and config mixed in this structure I
suspect the cleaner option is to re-factor SCSIBusInfo into
SCSIBusConfig and SCSIBusOps so you can keep the static around. But this
would touch quite a bit of code.

> +
> +    virtio_scsi_scsi_info.complete =3D virtio_scsi_command_complete;
> +    virtio_scsi_scsi_info.fail =3D virtio_scsi_command_failed;
> +    virtio_scsi_scsi_info.cancel =3D virtio_scsi_request_cancelled;
> +    virtio_scsi_scsi_info.change =3D virtio_scsi_change;
> +    virtio_scsi_scsi_info.parse_cdb =3D virtio_scsi_parse_cdb;
> +    virtio_scsi_scsi_info.get_sg_list =3D virtio_scsi_get_sg_list;
> +    virtio_scsi_scsi_info.save_request =3D virtio_scsi_save_request;
> +    virtio_scsi_scsi_info.load_request =3D virtio_scsi_load_request;
> +    virtio_scsi_scsi_info.drained_begin =3D virtio_scsi_drained_begin;
> +    virtio_scsi_scsi_info.drained_end =3D virtio_scsi_drained_end;
> +}
>=20=20
>  void virtio_scsi_common_realize(DeviceState *dev,
>                                  VirtIOHandleOutput ctrl,
> @@ -1289,6 +1292,7 @@ void virtio_scsi_common_realize(DeviceState *dev,
>      int i;
>=20=20
>      virtio_init(vdev, VIRTIO_ID_SCSI, sizeof(VirtIOSCSIConfig));
> +    virtio_scsi_init_scsi_info(&s->conf);
>=20=20
>      if (s->conf.num_queues =3D=3D VIRTIO_SCSI_AUTO_NUM_QUEUES) {
>          s->conf.num_queues =3D 1;
> @@ -1379,6 +1383,8 @@ static const Property virtio_scsi_properties[] =3D {
>                                           parent_obj.conf.virtqueue_size,=
 256),
>      DEFINE_PROP_BOOL("seg_max_adjust", VirtIOSCSI,
>                        parent_obj.conf.seg_max_adjust, true),
> +    DEFINE_PROP_UINT16("max_target", VirtIOSCSICommon, conf.max_target,
> +                        VIRTIO_SCSI_MAX_TARGET),
>      DEFINE_PROP_UINT32("max_sectors", VirtIOSCSI, parent_obj.conf.max_se=
ctors,
>                                                    0xFFFF),
>      DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSI, parent_obj.conf.cmd_pe=
r_lun,
> diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-s=
csi.h
> index b6028bb5cd..3998b241f6 100644
> --- a/include/hw/virtio/virtio-scsi.h
> +++ b/include/hw/virtio/virtio-scsi.h
> @@ -54,6 +54,7 @@ struct VirtIOSCSIConf {
>      uint32_t virtqueue_size;
>      bool worker_per_virtqueue;
>      bool seg_max_adjust;
> +    uint16_t max_target;
>      uint32_t max_sectors;
>      uint32_t cmd_per_lun;
>      char *vhostfd;

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

