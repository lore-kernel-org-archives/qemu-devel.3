Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67065606A326
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IVWrEgvI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQhI0-00053b-Jk; Tue, 10 Nov 2026 03:33:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xQhHy-0004xw-4s
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 03:33:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xQhHw-0003OW-DB
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 03:33:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794299586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=P95dhq8bBzNrU7EuCOOoNmwBndrpc2c48lPVxmjRFHc=;
 b=IVWrEgvIBrfRFUU1iVc491urWAYgLw2HVySUrhBBP1WxwISE8D+fyMlk1gPW/EVhhZi4yq
 hF7W3mv4nacGPMBUvRpB+dRt3J+jKKkICODT0PR8hGMIe1qYv6UcG9QfomBCk2bDAevTIO
 BI3+hz7072cXLdaHeTnzcU2j6hPKOYQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-YM0ak3yqOMOzD7CiDbyTOw-1; Tue,
 10 Nov 2026 03:33:01 -0500
X-MC-Unique: YM0ak3yqOMOzD7CiDbyTOw-1
X-Mimecast-MFC-AGG-ID: YM0ak3yqOMOzD7CiDbyTOw_1794299580
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA8B01800618; Tue, 10 Nov 2026 08:32:59 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 77B3B30030FF; Tue, 10 Nov 2026 08:32:57 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 0/4] virtio-gpu: reject non-32bpp cursor resources
Date: Tue, 10 Nov 2026 12:31:10 +0400
Message-Id: <20261110-master-v1-0-7a0505d6c259@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQwMT3dzE4pLUIt0kM1NLS0vzVOOkVGMloOKCotS0zAqwQdGxEH5xaVJ
 WanIJSLdSbS0A9iD0XGoAAAA=
X-Change-ID: 20261104-master-b659997e3be3
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Gurchetan Singh <gurchetan.singh.foss@gmail.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2033;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=UekuEEndDJk5eXP3vWaoSTHVVGj2RVtOfz5HRxkwGTI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq8ta3Fs5ayNo3W/otpU0CH7MfWZGgo/+XVPFsp
 OeCbOxvDqOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCavLWtwAKCRDa6OEJdZac
 5VSRD/9MZi0RhrlcIJNf6mTMiijaRVIHu8TjCq/h7AqkYO0t+fx9QIR8wu50EFudYdHURIWtSAN
 9mNaMvofvzLLjf80J1nQIe6ais2iYxjd2/PU1Bs2lKfP3u8W6AHLzJmXLonpXZUNxKx3WVKMEXF
 UJvrOMXzpU2HiPqIIr8JORr6CWMu3dl5iwfykGdFJp4Gcc5tIMf78bkoYbbDabf+GgphgzeKUm4
 qkx3FQNlx1o210U12qw/2196ja1KqGs/XkbSd9bvppGbatfef5lN3Y3BFzKBBYM54jBkAAl4JbK
 f8+uTTV7hBl2K002VM7FYcrekqwTnqylYHoa7f9rTyaN6h21LhS9iC5/14S9KO89QrI1V+hn6K5
 Xhk0opqj2DYTH1+yAt7O5SsVQsITWIyzS/UleoAVf1u5KQ+zDmTZE1NsUtY76z0tjllTLzM3wHX
 ThXfppX5qIQqthDmcGWW1AG3thevuOOo5xyJebsV+tXMMAR6FyS7aZkucRVIpfEH1BkpC4LxJCJ
 kVF42GHnWrLbTB3oLPY4R+V740+7Af09dPFWxanKAkZo1/qsh585sbdMN61ChAeAiyGWKkymlOW
 c97GQE6fIF33n1dNES7KixDrSFmpu6quln26gRwDG1qJW8geCViNyp35BdTl9fd1QkvFw21BhMR
 eiumS2JUTBeAK3g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Cursor data is copied out of the resource as 32bpp BGRA by every
accelerated backend, but none of them checks the resource format first.
(the 2d backend rejects any resource format that is not 32bpp already)

Refuse cursor resources that are not 32bpp in the three backends,
reusing virtio_gpu_get_pixman_format() as the allowlist, and log the
dimension mismatch in the rutabaga backend as the others do. Supported
formats keep working unchanged.

The vhost-user-gpu cursor path also leaked the virgl buffer when the
size check failed, so a guest could grow the backend memory with
repeated UPDATE_CURSOR commands. Release it with g_autofree, and skip
the update instead of sending zero-filled cursor pixels when no data
was produced.

First patch is a trivial cleanup.

The virglrenderer side is fixed with
https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1703

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4756
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
Marc-André Lureau (4):
      virtio-gpu: make some 2d callbacks statics
      virtio-gpu/gl: reject non-32bpp cursor resources
      virtio-gpu/rutabaga: reject non-32bpp cursor resources
      contrib/vhost-user-gpu: reject non-32bpp cursor resources

 contrib/vhost-user-gpu/vhost-user-gpu.c | 31 ++++++++++++++++++++-----------
 contrib/vhost-user-gpu/virgl.c          | 25 ++++++++++++++++++-------
 contrib/vhost-user-gpu/virgl.h          |  2 +-
 hw/display/virtio-gpu-gl.c              | 18 ++++++++++++++++++
 hw/display/virtio-gpu-rutabaga.c        | 19 ++++++++++++++++---
 hw/display/virtio-gpu.c                 | 12 +++++++-----
 include/hw/virtio/virtio-gpu-pixman.h   | 13 +++++++++++++
 include/hw/virtio/virtio-gpu.h          |  4 ----
 8 files changed, 93 insertions(+), 31 deletions(-)
---
base-commit: 723622bedb0b423de7d1c61ebbe6e7a71934949c
change-id: 20261104-master-b659997e3be3

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


