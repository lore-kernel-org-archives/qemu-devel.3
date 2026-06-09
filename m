Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE05CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 21:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX4JQ-0007K9-04; Tue, 09 Jun 2026 17:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wX4JJ-000766-P3
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wX4JI-0008LJ-6J
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781041714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x9df3D1OcVRLhW68JfjOyeuqEIxrABvgwQ/ib1YLU6c=;
 b=Ry97dB6HD3aXaBl3a8b0fniAYlVzHHwTvYBEhVz8l8lP2WUMoEPk9Li3AeFGtJjSKHPXDL
 1Hk62g1RgCh2XtTuUXD4XX6hZgS/JV0nInlK/YYyCkk0/qvq+rIE6qgvrDA+Kk+WSaGV8a
 tNIPzfoZAHsp3ZUPN4v2XeeNguSKZ/k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-WFiRCIUOPRiSBuB5hllYjA-1; Tue,
 09 Jun 2026 17:48:31 -0400
X-MC-Unique: WFiRCIUOPRiSBuB5hllYjA-1
X-Mimecast-MFC-AGG-ID: WFiRCIUOPRiSBuB5hllYjA_1781041710
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C8F31800A3B; Tue,  9 Jun 2026 21:48:29 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3E21219540D8; Tue,  9 Jun 2026 21:48:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 11/12] virtio-serial-bus: add terminal resize messages
From: marcandre.lureau@redhat.com
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Szymon Lukasz <noh4hss@gmail.com>
In-Reply-To: <20260609-console-resize-v7-11-0c550fdcec15@gmail.com>
References: <20260609-console-resize-v7-0-0c550fdcec15@gmail.com>
 <20260609-console-resize-v7-11-0c550fdcec15@gmail.com>
Date: Wed, 10 Jun 2026 01:48:13 +0400
Message-Id: <178104169394.926568.17414135479607015116.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1035;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=kOvyoBWPSWJ3ORv5r/lh3OyXOS8j+C2Qt64RiHgUgVw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKIojtDQ5w8bzzz2BwOszakSBOAqukZiS56Dnw
 /3B6nxcYhuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiiKIwAKCRDa6OEJdZac
 5W+7EACcuWIWjMyRdR0ML4oEkSW5neZY5jU52vUGmOkBtX+YS18yRYpuv+QfRbwoGoGvPRMMiIx
 8In1/QkKsd6J9sx8U4mS3o3rvrCOwDT5R+rb5rnPXLGfwiuGu4pm+biqJwHvvN1holp7wKiNkj8
 rAg3stce1Dv/62ZUhHZ8n3nbs1h/PB9XhrUt5Ce5jdbz8xassnBR4x99tVKaV97pQYfylhf9Vat
 phNMknF+8ROvPdBXuvmffXOeMBASgDLDOpeKfojyUfysuEcPLdYj+0qgyyoQ0Nv+rCSB1NUm5Mh
 hfrWytwusSW6Z5j+l/TmqzhSDkz1rUIqIQX83QHhwPSRqHioc9Nzrp6MdSZg2jOsfZF8EHlCRCP
 8WLI5R7XjnDZW9maRrcXk1ffqROcDhB2wTcSmIWZctjLc48xKcNHrlh1wQ0cuSUAi1uj3n64Hnw
 yYkPeQnSIATi225vT341kQloIWciEuR0ug7tMAHkcAijeZd/KyFVfvLkVXSUh7LQH4Y2XRtNYYc
 xUf4iVGVrfJVtk4mfoP7TRTMNu45W7wngzNzKhOH0fNGxSNImvNBYpOIttS/igWNk3jM8hE1gAn
 YKrWa9OHGfRKWv+84CeElZZHI3witsbzRMPPqef7eFoAQ9CfK2zP+rIUH70bCx0LbUk8KeHzRI5
 tkjxFx9ud1/Q4gg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, 09 Jun 2026 21:16:21 +0200, Filip Hejsek <filip.hejsek@gmail.com> wrote:
> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> index cd234dc6db1..a31e80cfdee 100644
> --- a/hw/char/virtio-serial-bus.c
> +++ b/hw/char/virtio-serial-bus.c
> @@ -260,6 +260,68 @@ static size_t send_control_event(VirtIOSerial *vser, uint32_t port_id,
> [ ... skip 22 lines ... ]
> +
> +    if (use_multiport(vser)) {
> +        struct {
> +            struct virtio_console_control control;
> +            struct virtio_console_resize resize;
> +        } buffer;

Initialize the buffer to = {},..

> +
> +        virtio_stl_p(vdev, &buffer.control.id, port->id);
> +        virtio_stw_p(vdev, &buffer.control.event, VIRTIO_CONSOLE_RESIZE);
> +        virtio_stw_p(vdev, &buffer.resize.cols, port->cols);
> +        virtio_stw_p(vdev, &buffer.resize.rows, port->rows);

..otherwise whatever is on the stack at control.value is sent to the guest.

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


