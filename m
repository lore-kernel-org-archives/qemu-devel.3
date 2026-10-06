Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74ACDCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMwE-0004P9-Ia; Wed, 07 Oct 2026 04:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1xEHhv-00063Z-TT
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:48:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1xEHhp-0003uA-Ai
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791341198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Y2Cf0qiwbTYW8nwxamly50QakA7MVWZfoaEl6TzEfA=;
 b=FebkC19PRkTNFmH9q8rLkK25yW2nywsA9ouilOp4frO8bFY/h0LA0SWgLTFpKLAUSuIty7
 q7iSBSUB/HSfPUUpGqT0h6cctysK2enWo0UZPlGJu+7euaxKstSj8tP4oP5qzFg4mxEvJL
 akF2OKnZfAcqz5EUpjmDWWIeb3ROXyM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-4KN5PfRcMXSrnO-KkOiFVw-1; Tue, 06 Oct 2026 10:12:18 -0400
X-MC-Unique: 4KN5PfRcMXSrnO-KkOiFVw-1
X-Mimecast-MFC-AGG-ID: 4KN5PfRcMXSrnO-KkOiFVw_1791295937
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a170fa0879so15182495e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 07:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791295937; x=1791900737; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0Y2Cf0qiwbTYW8nwxamly50QakA7MVWZfoaEl6TzEfA=;
 b=e4owKprGQ/CjZd4hPqd39wY5bPxmp0Nz63hHXoJ0cM13dvvCxRZZQA8LN6F2hO+6v2
 D7t9L7+uzBlCgJvb+0INxZe3lZIm8XZo8/0cWRZjTKjiM8sX8xYKeocy3Pu5izi+pPAV
 5CyxtjfkpKjYiQaDJ3Fv5dRmfTx42Uj24y+/C0zdcYjFVtr72eIyjVn+UupyRaOgGygk
 9IuruogdygqgQaMHA/gb8yXlbjHaivVhlH+FSxN2XNWUeF0RecFgVTtsq2c3oY3QqU2M
 T0hZK00vo7qaMWXRFx2VCq59Ov6wXVWvk3Z5CLx9SwJVSdN1Wn8ghuSoTHpZcj69e830
 /FVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791295937; x=1791900737;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0Y2Cf0qiwbTYW8nwxamly50QakA7MVWZfoaEl6TzEfA=;
 b=B+UFL3+P+OkuQZ96VXi9xNhmL4B0ltlLO/yj8LBAR9QF19LpT4JAflHVQ+Kd5xKsy5
 ZWiM3RQZ8VhyC3oOict8ViY2CdIzE7QlHioCDEah5K6zomF49WSRRJSr9yrgyBS0Rl8g
 fVLh8EF0lWMxqppsijSZGtkI7wi9VS4M7Sviz+aHcmUoa46iOJhlw2mvm6r9isLZfSnp
 d4qLoN6LVXi/YHOAI4FSmm4efYBXt+GLbRm4fjUSKr5pPVnqqiLUmzfe0vI70EXNpI5/
 qzVPvlT0aJ2nQPmuYr2pBDmJNcyr4yZJ/JG0+Nb0wJJzHWGvYoX94CJu2zVe5X6xOqhA
 Wnmg==
X-Gm-Message-State: AFuF++lzGp8/8aGYufjA1Uw9vHvfYciFBd4M64SnMWA3w9mHa/zNuAja
 XkvSy3I8UzyVUzndhiHb0DmHL8fNsU7K4gpEIbIspHwbHew1zI3J26W+zfFQkoRpqIAtspefmvH
 1CAiHqxeS1F2VkZa+OuuzosMPydDLfwiFIUAdXg1exRxV9YZj/70dTPdm
X-Gm-Gg: AYBFou1Kd4fePAb/8YWpNR+0ypSX+h5tkmC2vVPOHeQXDLLMxGNnF4OfNOO1KKdCnGx
 7nrzb1WiJpNGW66M8VLRfjaw4M+hrci+Teag+f+UHLNvgnJvtsuX5H9h21DEXQB+w2NO0affQEn
 2zZY1AoF7frvf87Zh7XYQhjhgvam2b8zs0D4wSZhmmsjBrE7zdSATant6t7CNTGOEs55hOFVmTO
 PD8byAamtc7oaFHYHPJKpHIES7/M1oRNXnbQhbL3ciLlDvv0UZqeYw0jihdldDbcjSAksrojo04
 Pffifk0l4V3p13b9GVpJ2yqPwFXHGEPOlkCdmqzLuX+hcPd7ChT1Uqr4SiMWQyzMLNamfjIPyFP
 tuXSaxc1s4ExPG5+zwB8wXWk+UCmPGncpclQ=
X-Received: by 2002:a05:600c:4705:b0:49c:fc6c:be08 with SMTP id
 5b1f17b1804b1-4a17b54ec4dmr26934995e9.31.1791295937121; 
 Tue, 06 Oct 2026 07:12:17 -0700 (PDT)
X-Received: by 2002:a05:600c:4705:b0:49c:fc6c:be08 with SMTP id
 5b1f17b1804b1-4a17b54ec4dmr26934265e9.31.1791295936484; 
 Tue, 06 Oct 2026 07:12:16 -0700 (PDT)
Received: from leonardi-redhat ([176.206.38.69])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a178c53997sm112426335e9.12.2026.10.06.07.12.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 07:12:16 -0700 (PDT)
Date: Tue, 6 Oct 2026 16:12:07 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Tommaso Califano <tcalifano@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH v2] hw/usb: Fix USB MTP heap OOB read via dlen underflow
Message-ID: <asUBcqRi6PVnxA_E@leonardi-redhat>
References: <20261005162549.120647-1-tcalifano@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261005162549.120647-1-tcalifano@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Oct 05, 2026 at 06:25:49PM +0200, Tommaso Califano wrote:
>In QEMU’s USB MTP device, usb_mtp_write_metadata() computes
>filename_chars = dlen - offsetof(ObjectInfo, filename) where
>offsetof(ObjectInfo,filename) = 53. The dlen parameter is the size of the
>last USB packet, not the total ObjectInfo size. If the final packet has
>fewer than 53 bytes, filename_chars underflows to SIZE_MAX, causing
>utf16_to_str() to read far beyond the heap buffer, leaking QEMU host
>process memory.
>
>Replace dlen with d->length to avoid this issue, given that the latter
>represents the total size of the buffer allocated for the unsegmented object.
>
>Fixes: 90c1a74271ce ("usb-mtp: Limit filename to object information size")
>Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3992
>Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
>---
>
>v2:
> - Remove the dlen guard and variable in favor of using d->length.
>
> hw/usb/dev-mtp.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
>index 1d8cfd32dc..53b5904a5c 100644
>--- a/hw/usb/dev-mtp.c
>+++ b/hw/usb/dev-mtp.c
>@@ -1696,7 +1696,7 @@ close:
>     s->write_pending = false;
> }
>
>-static void usb_mtp_write_metadata(MTPState *s, uint64_t dlen)
>+static void usb_mtp_write_metadata(MTPState *s)
> {
>     MTPData *d = s->data_out;
>     ObjectInfo *dataset = (ObjectInfo *)d->data;
>@@ -1704,7 +1704,7 @@ static void usb_mtp_write_metadata(MTPState *s, uint64_t dlen)
>     MTPObject *o;
>     MTPObject *p = usb_mtp_object_lookup(s, s->dataset.parent_handle);
>     uint32_t next_handle = s->next_handle;
>-    size_t filename_chars = dlen - offsetof(ObjectInfo, filename);
>+    size_t filename_chars = d->length - offsetof(ObjectInfo, filename);
>
>     /*
>      * filename is utf-16. We're intentionally doing
>@@ -1801,7 +1801,7 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
>         if (d->data_offset == d->length) {
>             /* The operation might have already failed */
>             if (!s->result) {
>-                usb_mtp_write_metadata(s, dlen);
>+                usb_mtp_write_metadata(s);
>             }
>             usb_mtp_data_free(s->data_out);
>             s->data_out = NULL;
>-- 
>2.55.0
>

IIUC, `d->length` is controlled by the guest, so I think we still need
the check that was present in the v1.

Thanks,
Luigi


