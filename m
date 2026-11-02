Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1A3606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 07:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gbzf2sEQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNmn3-0004g4-EV; Mon, 02 Nov 2026 02:49:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNmmg-0004fW-P6
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 02:48:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNmme-0000Xs-RB
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 02:48:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793605727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cCefLyL86+adSaMeM4HtVeKFuFWwvNawpQamsgYJk98=;
 b=Gbzf2sEQUQlKoV06tL/UjSdwz59Kub8HhbWWA+5wizvPHM+BDwjxROZPA1PcpLpYbtyqsg
 wfvNdpqPtFHdGjKG1fm8CVO+xXKIl0jcU2LRbZNOK/Q6w5ThbAjDSOBP3rdPunZukPzA5v
 emAQMT+17EVbutBgHTq3wZh+cgAmhuM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-XGteysg6OyeavB2zmU4HNA-1; Mon,
 02 Nov 2026 02:48:44 -0500
X-MC-Unique: XGteysg6OyeavB2zmU4HNA-1
X-Mimecast-MFC-AGG-ID: XGteysg6OyeavB2zmU4HNA_1793605722
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F00D180AC4E; Mon,  2 Nov 2026 07:48:42 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BFFBA1955F01; Mon,  2 Nov 2026 07:48:40 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/4] net: Consistently pad short packets for all backends
From: marcandre.lureau@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Jason Wang <jasowangio@gmail.com>, 
 Samuel Thibault <samuel.thibault@ens-lyon.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>
In-Reply-To: <20261027174625.4025878-1-peter.maydell@linaro.org>
References: <20261027174625.4025878-1-peter.maydell@linaro.org>
Date: Mon, 02 Nov 2026 11:48:36 +0400
Message-Id: <179360571623.2763172.9344539923724876491.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1682;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=V4gdeCFSWlA6InX0H6pYt8R+OynMSL+XAgSE6ZQHbhY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq6EBVu/e27ahw4LAffxuD2xQTAiVbeeTBSpxnt
 m0UAuiszOCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauhAVQAKCRDa6OEJdZac
 5UTkD/47RZi5/OcO9inzSx78dF9k9/CMDqUH360/wEg4X82E/JxxbYLRImKEO0FnpYGgck/TQp0
 ADlOHnj7Pff8oJqrdK6dOCkS4kWTLP8qst7qonqghK2i1h/YKb061zc8gBu0zg6MWlE7JKZG2L+
 IZjAxNapJj8mbN+d38nqOzvKo+HcAEUnpQAnylepYinz7KxKv+k34WBKQ7PF+l1y3T1whJxebvJ
 mNlda6xTF0SsyhZAsBcFI3069Dz9ou8D7+3ZhhJjl8EeCGXr56K/3v1ep/u3ESkTfuqARf8mlWx
 tzpgIPP17DwRN2z7ci9kDuHkiiRCtylt2xve/NZp6i46IU7w4rNq7OA3SlR7sFtG917X/Onrj5o
 mm4Ky+kK1IfHSbQxTq4Y9kTo/8i9GrIB0vVq+OPmBC1nYUsPC7/GJUhpxkKxIkIBO/2PJqk0xz6
 bXN2w5taad4E1acpoS8d5Q0NU5KlukZCwL3ICZjnxAXCK9bXJLbJkqWF/gqQ3yc8FoXKGkDYOwD
 O6nE9i3QxFXTWTPdB0qfJRM9MzoKNEdU/WderjQ/YjMjq0QW4xXxRdGOIQse7YYRnuiEe8mISVc
 Xk2KY94C+J5hgg78bNZv+cjpGfvi9nmVNQ8E+y11NqPNadcQiYHPE83o0b8i7jnZmf9lXELj24e
 E8SN60MI+LvJ11Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> The net core code design is that by default packets are padded out to
> the ethernet frame minimum before being handed to a network device
> model, unless that device explicitly opted in by setting do_not_pad.
> This avoids a whole class of bugs where network device receive code
> has to be very careful about handling short packets.
> 
> However, at the moment we do this check manually in the network
> backend code before it calls qemu_send_packet() or
> qemu_send_packet_async(), and we forgot to do it in all backends.  So
> you get the padding for the slirp, tap and vmnet backends, but not
> for the "minor" backends like 'passt', 'socket' and 'dgram', or if
> you configure two network devices connected by an emulated hub.
> 
> This series fixes this by moving the padding code to
> qemu_send_packet()/qemu_sendv_packet(), so that it always happens
> regardless of the backend.
> 
> The main bug this is fixing is
> https://gitlab.com/qemu-project/qemu/-/work_items/2362
> but it's been re-reported multiple times for various combinations
> of network devices and backends.
> 
> The whole series is cc stable because without the padding you can
> provoke various bugs in different network device models.
> 
> thanks
> -- PMM
> 
> Peter Maydell (4):
>   tests/qtest: Make netfilter tests accept padded ethernet packets
>   net: Set do_not_pad for net backends
>   net: Pad short packets in qemu_send_packet and qemu_sendv_packet
>   net: Remove padding code from net backends

just a minor comment, otherwise lgtm

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


