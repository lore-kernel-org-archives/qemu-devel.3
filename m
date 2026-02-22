Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF19C636A0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 14:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuASr-0000hK-2X; Sun, 22 Feb 2026 09:29:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuASm-0000GU-Ac
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:29:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuASj-00071y-J9
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:29:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771770572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J7AJZnREnnuh4n1i+AX40VBaQWcsT67HBrhxUk6jlr8=;
 b=i8Ubzms7HkjbSeYiNkU8CcEddnWxGbL0hEboWNHQABWjBAmub5Odih62Gvp2XCP+Td4Vt5
 1sHvfxTIb36ZIiquxkq/P6UJXTVAT0QGA5jDnKNoZADuOR1oB08aRxlPvVlBFHYdKAnOep
 sbYluteesQRE7i95dT8oHyqOMJSsdho=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-1unnFZ5kMUqHbLLR-ZEISQ-1; Sun, 22 Feb 2026 09:29:30 -0500
X-MC-Unique: 1unnFZ5kMUqHbLLR-ZEISQ-1
X-Mimecast-MFC-AGG-ID: 1unnFZ5kMUqHbLLR-ZEISQ_1771770569
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4837cee2e9bso6425305e9.3
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 06:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771770569; x=1772375369; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=J7AJZnREnnuh4n1i+AX40VBaQWcsT67HBrhxUk6jlr8=;
 b=gUouyI+Fmp6dARRwxEQy6hd8VKdA06M823EZQcz8xxDWFxGHHQAa7AifDYuV50AQ4L
 u0fe8noDwT7Hs+HGtMq8lrH5LhHb9mpYXmG6UljbcaiEdrlo4bGCm0rOvsMgW+wF9IKy
 Bd+Y0I7oN7BmqRxbPJLn8hdR6LMcfLZ7y7js4o5ZBotITP+R7oBCsYQGk0KhPDL63HYw
 I/gRli6kFoSjIK2SXDlYoK2OGkKuCkmqtjPQWVqhbSBu0pkjNet4iWnqzNBMfkst23Ug
 pR9CEqSEEKYOGqMtUcfIGg6e0G6yA6v3L5Jwme3FuEz2zS5iwLrQaxFzJK1T73qA0EDY
 MHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771770569; x=1772375369;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J7AJZnREnnuh4n1i+AX40VBaQWcsT67HBrhxUk6jlr8=;
 b=eP5hnYRijomCp6pBvF4L+g+K9/y2fmRZKWJduQ5iqBC9X3RRjbQFmAlydBDAz7tdCJ
 ZkkFYQ9+O7dfMlFiuoe81CeXkQmUIVfAgDaW+dx7Q4HrxrggQIfnpjpM7ltEmoou0LPr
 PTyhb8Hma+3CTzIz5/fkgQKJJFLfiN0Qzt/8HszxXyPhmt1Npw8vN8Q02ZaJijovzv6G
 axrMK3lQlBNU4QCTweaPAWXX+xq/ScvAl6GiqZ8j2Mn/128fWghzt6ZhCsX+W5ILimMa
 +qOIOdb+pVn3/WnNsQ0Fk6cPPKXd9XRlM29mlTnAjX0f6ufIypW9b313lnLNhPkPsXHP
 lqdQ==
X-Gm-Message-State: AOJu0YxEsw8iZabyysYIsgdLBxpGsevU2nc8cnSk3XNyPWsnrg94c7c4
 lGLhekr2eNy7i8YzTUWnpz5SxdLKo3jUMbRFMy1FUyXu4OhSz25qBYSsqCuOol/ejz3SFH3ZyZo
 eepT0lmXelc1oM4QYI9OdSqiSleSdHxyJ4XnFrp+Qi5juQsE+qSe0DyMkmRSrLyquziT+HZ/Nre
 FgNivmBFyzMaNOOb6Wg5g4xvsiEBWfNaFayg==
X-Gm-Gg: AZuq6aI5JI5tn4CCKOplua5Tcuu0G7/XI36Q0jo0sgGkGCFeCW9pM1AUpNjw5FFhcj0
 lL6IgdrmTtjdKbSekdscO7ZC/M8/vOR1vzO+JpO+ByX3plkY89rwq6XL4xUha36v0eAhfu5tORu
 H8MgwD0XNC2p4Ouj+HSTcO3JXUi1F7xK0zV7ESBwhuwJDSWhiqwdkaDYSjHEDgKXDJhFJPn3dCk
 SHm8pvETF0kDyaaD1REqgpKxghPrEfwiOqvEc8GAcF3DJG94CeblSLcLbVWuimfB+f6b3+vOCXV
 vegwX+NNIUprbxb+NDM5pLoKl7Jx2nnIlpchXgQFJtivgvBHEpwH+etekAq4+AjkICi0tHWHqyT
 /bHBipbJqPNd7p+rgRAT4NszawZ0lV4U4FYlyZYEH3ZpcwQ==
X-Received: by 2002:a05:600c:1e0f:b0:46e:4a13:e6c6 with SMTP id
 5b1f17b1804b1-483afea0266mr23819735e9.19.1771770568780; 
 Sun, 22 Feb 2026 06:29:28 -0800 (PST)
X-Received: by 2002:a05:600c:1e0f:b0:46e:4a13:e6c6 with SMTP id
 5b1f17b1804b1-483afea0266mr23819295e9.19.1771770568082; 
 Sun, 22 Feb 2026 06:29:28 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d54760sm12545551f8f.35.2026.02.22.06.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 06:29:27 -0800 (PST)
Date: Sun, 22 Feb 2026 09:29:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 29/33] virtio-snd: remove TODO comments
Message-ID: <34238f078a04f24b91199249b83846ab082b4e05.1771770471.git.mst@redhat.com>
References: <cover.1771770471.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771770471.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Replying with a VIRTIO_SND_S_BAD_MSG error does not warrant a device
reset. Instead, a device reset happens when the driver requests it from the
transport.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260220-virtio-snd-series-v1-2-207c4f7200a2@linaro.org>
---
 hw/audio/virtio-snd.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index ed0422b45a..232179a04a 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -168,9 +168,6 @@ static void virtio_snd_handle_pcm_info(VirtIOSound *s,
                                sizeof(virtio_snd_query_info));
 
     if (msg_sz != sizeof(virtio_snd_query_info)) {
-        /*
-         * TODO: do we need to set DEVICE_NEEDS_RESET?
-         */
         qemu_log_mask(LOG_GUEST_ERROR,
                 "%s: virtio-snd command size incorrect %zu vs \
                 %zu\n", __func__, msg_sz, sizeof(virtio_snd_query_info));
@@ -184,9 +181,6 @@ static void virtio_snd_handle_pcm_info(VirtIOSound *s,
 
     if (iov_size(cmd->elem->in_sg, cmd->elem->in_num) <
         sizeof(virtio_snd_hdr) + size * count) {
-        /*
-         * TODO: do we need to set DEVICE_NEEDS_RESET?
-         */
         error_report("pcm info: buffer too small, got: %zu, needed: %zu",
                 iov_size(cmd->elem->in_sg, cmd->elem->in_num),
                 sizeof(virtio_snd_pcm_info));
@@ -244,9 +238,6 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
     virtio_snd_pcm_set_params *st_params;
 
     if (stream_id >= s->snd_conf.streams || s->pcm->pcm_params == NULL) {
-        /*
-         * TODO: do we need to set DEVICE_NEEDS_RESET?
-         */
         virtio_error(VIRTIO_DEVICE(s), "Streams have not been initialized.\n");
         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     }
@@ -297,9 +288,6 @@ static void virtio_snd_handle_pcm_set_params(VirtIOSound *s,
                                sizeof(virtio_snd_pcm_set_params));
 
     if (msg_sz != sizeof(virtio_snd_pcm_set_params)) {
-        /*
-         * TODO: do we need to set DEVICE_NEEDS_RESET?
-         */
         qemu_log_mask(LOG_GUEST_ERROR,
                 "%s: virtio-snd command size incorrect %zu vs \
                 %zu\n", __func__, msg_sz, sizeof(virtio_snd_pcm_set_params));
@@ -610,9 +598,6 @@ static void virtio_snd_handle_pcm_release(VirtIOSound *s,
                                sizeof(stream_id));
 
     if (msg_sz != sizeof(stream_id)) {
-        /*
-         * TODO: do we need to set DEVICE_NEEDS_RESET?
-         */
         qemu_log_mask(LOG_GUEST_ERROR,
                 "%s: virtio-snd command size incorrect %zu vs \
                 %zu\n", __func__, msg_sz, sizeof(stream_id));
@@ -624,9 +609,6 @@ static void virtio_snd_handle_pcm_release(VirtIOSound *s,
     trace_virtio_snd_handle_pcm_release(stream_id);
     stream = virtio_snd_pcm_get_stream(s, stream_id);
     if (stream == NULL) {
-        /*
-         * TODO: do we need to set DEVICE_NEEDS_RESET?
-         */
         error_report("already released stream %"PRIu32, stream_id);
         virtio_error(VIRTIO_DEVICE(s),
                      "already released stream %"PRIu32,
@@ -669,9 +651,6 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
                                sizeof(virtio_snd_hdr));
 
     if (msg_sz != sizeof(virtio_snd_hdr)) {
-        /*
-         * TODO: do we need to set DEVICE_NEEDS_RESET?
-         */
         qemu_log_mask(LOG_GUEST_ERROR,
                 "%s: virtio-snd command size incorrect %zu vs \
                 %zu\n", __func__, msg_sz, sizeof(virtio_snd_hdr));
-- 
MST


