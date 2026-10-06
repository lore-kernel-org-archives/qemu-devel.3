Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899A3CA6009
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMrY-0005bB-IU; Wed, 07 Oct 2026 04:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifan@redhat.com>)
 id 1xEH6P-0001dq-UF
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:10:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifan@redhat.com>)
 id 1xEH6C-0005Mg-Pu
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791338775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M89lxZsuxChm9n3jZxG+XCC2e0PMpR73WMg/cEbQG2Y=;
 b=hyojw0e5ZslAa3LVTpj+FD0pZZKzs0ue5+YnXnyr70Yr5MQaSOEqaM5kKiWgyXIwi9XG94
 anOparDnk6SBb0k2LuvpXdIGzAtEsTjTftA6ATUgZ9FK+4XIS5G1QJWa7IMGE+4E7aCGjW
 hT51LQ2ijcVhch2WrH5yj3TQBczQjcc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-2_0tyKkxPNilxmJkYDloLg-1; Tue, 6 Oct 2026 16:38:38 +0000
X-MC-Unique: 2_0tyKkxPNilxmJkYDloLg-1
X-Mimecast-MFC-AGG-ID: 2_0tyKkxPNilxmJkYDloLg_1791304718
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a1721559b4so21553545e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 09:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791304717; x=1791909517; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=M89lxZsuxChm9n3jZxG+XCC2e0PMpR73WMg/cEbQG2Y=;
 b=b3cIB+nvBdiNSAqXji7yeqFA434aKC2kyOgMpn6LSj1MX19uKJhNKDmBh7Nsh09gPw
 zSXUBvDDg5qv+B6u6njnRhnZ6kGoD9lW+DBB4MTjJ6FRlwzN0eWtAncwsnpXGpDHa8Xt
 wmH3Iun2Siu/ccLOc568nAA9cD+vatzuIeVPyHBUFrfbIM9CN4BLl9xgH6mwHDgOrN8D
 0H6g+yHHIfxT3i1oKFs5ZRvhJJnxjwfhej5Qz4rzAy2nTgyg7Fp4fhHXMTlGe42eJ8XM
 J2PL+1oJpZvupA3QEF/dOF4mgp5PDidamWywGCH85YnKLX7tLhYyHlSve7z4p/VJQM71
 Js1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791304717; x=1791909517;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=M89lxZsuxChm9n3jZxG+XCC2e0PMpR73WMg/cEbQG2Y=;
 b=kFTu9sHKbGuBDKV3PoCxcMQOY6dWKMMAo/N5NAqMna5CLb2UzE7xCTBDidVsu2tmvp
 Me8bI/OocGDcT3OA89j5ce7fiAZfNuE54qgoCdEtlwKPClZdm8n+jYxHCR+gIFuvjR4X
 UccN7asH58l5JgRZQc2q3NBJfwAhdOWd0ONLUkADYVyM5J2C4Mh2jyYKVIYeZtvXnXed
 5OSCGGtoH/J8tWZKMBwckt/xcn2ouSoj08B4PiBvZBQUPWT81lvAmOApDnXEHbKcKHC/
 DBscW0og955uz0NlZvY6OMfpmB3G1OPxezpZyphLkzUZdzxMsQ+GoN0oP4TOLP/kdja5
 k5RQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy+XH4EiTbRaSx2u40qgABjdDDpEOeSQh2cjIRiGQJwQYVpxgyPMKqG+Vw3lvpxATwtVgjwm0G4MNhw@nongnu.org
X-Gm-Message-State: AFuF++ktEThZCTAV/IEV6lCA1vU4dhV65IGW/hW3ZfTYl1g4kkYnFhpA
 p+t3JmbjUHiokgnUh5vLktpZcPOPcX7/ENnbpfevx+QD2l7dUWp9HabPf8Ueg7K746Xr612yxds
 RMpWasQjEIvl1GC7pwd8CaZ1gGz2CwMhBVhnCDMPjJ5Za8rqtBvVlPK+x
X-Gm-Gg: AYBFou0NkrqbM4CwG/a/WNhAe025ZF94V4k7eI9OQFiK6HXI48TB5pLMbZhKMkRo9aW
 QnILjIgumxYQoE2JO0DqEIq2V+rt/VFCQkAdG4K/yKdJ5lSSRx7SbP1rrrMNRQe9nsKsMEEvE2r
 3dkxaUl3sD7AXO2JX9sfVORskPkGjWmGlZoTpPknEFN4zqXYJDR+4Oxn9TjVf+dGFs4izsaW96V
 7uvY53C14upTKvOCJ0SRZXk5EbM8OaZI+ZGJ+3XfNQe7jlFxrNTiuJTFM1mreZCRUG2N/xV2qG8
 y/4CnoDNkPuMkG0Z70ecpdrILbliV3wimnSWlGxaymNnpPybzh8FP/OO17q94uwbSMFcCh4=
X-Received: by 2002:a05:600d:82c2:b0:49c:cee0:f383 with SMTP id
 5b1f17b1804b1-4a17b54978cmr39345285e9.16.1791304717681; 
 Tue, 06 Oct 2026 09:38:37 -0700 (PDT)
X-Received: by 2002:a05:600d:82c2:b0:49c:cee0:f383 with SMTP id
 5b1f17b1804b1-4a17b54978cmr39345025e9.16.1791304717215; 
 Tue, 06 Oct 2026 09:38:37 -0700 (PDT)
Received: from tcalifan-p1g8.csb ([213.175.37.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a178c53997sm123125045e9.12.2026.10.06.09.38.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 09:38:36 -0700 (PDT)
Date: Tue, 6 Oct 2026 18:38:34 +0200
From: Tommaso Califano <tcalifan@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Tommaso Califano <tcalifano@redhat.com>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH v2] hw/usb: Fix USB MTP heap OOB read via dlen underflow
Message-ID: <asUf_npZzV59e2rM@tcalifan-p1g8.csb>
References: <20261005162549.120647-1-tcalifano@redhat.com>
 <asUBcqRi6PVnxA_E@leonardi-redhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <asUBcqRi6PVnxA_E@leonardi-redhat>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=tcalifan@redhat.com;
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

On Tue, Oct 06, 2026 at 04:12:07PM +0200, Luigi Leonardi wrote:
>On Mon, Oct 05, 2026 at 06:25:49PM +0200, Tommaso Califano wrote:
>>In QEMU’s USB MTP device, usb_mtp_write_metadata() computes
>>filename_chars = dlen - offsetof(ObjectInfo, filename) where
>>offsetof(ObjectInfo,filename) = 53. The dlen parameter is the size of the
>>last USB packet, not the total ObjectInfo size. If the final packet has
>>fewer than 53 bytes, filename_chars underflows to SIZE_MAX, causing
>>utf16_to_str() to read far beyond the heap buffer, leaking QEMU host
>>process memory.
>>
>>Replace dlen with d->length to avoid this issue, given that the latter
>>represents the total size of the buffer allocated for the unsegmented object.
>>
>>Fixes: 90c1a74271ce ("usb-mtp: Limit filename to object information size")
>>Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3992
>>Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
>>---
>>
>>v2:
>>- Remove the dlen guard and variable in favor of using d->length.
>>
>>hw/usb/dev-mtp.c | 6 +++---
>>1 file changed, 3 insertions(+), 3 deletions(-)
>>
>>diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
>>index 1d8cfd32dc..53b5904a5c 100644
>>--- a/hw/usb/dev-mtp.c
>>+++ b/hw/usb/dev-mtp.c
>>@@ -1696,7 +1696,7 @@ close:
>>    s->write_pending = false;
>>}
>>
>>-static void usb_mtp_write_metadata(MTPState *s, uint64_t dlen)
>>+static void usb_mtp_write_metadata(MTPState *s)
>>{
>>    MTPData *d = s->data_out;
>>    ObjectInfo *dataset = (ObjectInfo *)d->data;
>>@@ -1704,7 +1704,7 @@ static void usb_mtp_write_metadata(MTPState *s, uint64_t dlen)
>>    MTPObject *o;
>>    MTPObject *p = usb_mtp_object_lookup(s, s->dataset.parent_handle);
>>    uint32_t next_handle = s->next_handle;
>>-    size_t filename_chars = dlen - offsetof(ObjectInfo, filename);
>>+    size_t filename_chars = d->length - offsetof(ObjectInfo, filename);
>>
>>    /*
>>     * filename is utf-16. We're intentionally doing
>>@@ -1801,7 +1801,7 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
>>        if (d->data_offset == d->length) {
>>            /* The operation might have already failed */
>>            if (!s->result) {
>>-                usb_mtp_write_metadata(s, dlen);
>>+                usb_mtp_write_metadata(s);
>>            }
>>            usb_mtp_data_free(s->data_out);
>>            s->data_out = NULL;
>>-- 
>>2.55.0
>>
>
>IIUC, `d->length` is controlled by the guest, so I think we still need
>the check that was present in the v1.
>
>Thanks,
>Luigi
>

Yes, you are right. I missed it. I'll re-add the check from v1.

I also noticed that with the guard in place it is still possible to craft a write where 
d->length == offsetof(ObjectInfo, filename): filename_chars is then computed as 0, so
utf16_to_str() returns an empty string and the device creates a file with no name. This
behavior already existed before, so it is not introduced by the patch. Since I think
that zero-length filename should never be valid, I'm inclined to make the check strict
and reject any ObjectInfo that does not "carry" a file name.


