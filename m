Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904B9CCD193
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 08:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vA25e-0003gK-4e; Sat, 18 Oct 2025 04:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vA25c-0003fg-Ob
 for qemu-devel@nongnu.org; Sat, 18 Oct 2025 04:15:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vA25a-0006hQ-8q
 for qemu-devel@nongnu.org; Sat, 18 Oct 2025 04:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760775295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FcwCAzl2Pz0avpVx7jAkFXZuqrxrzUl4WKWSVaClnOU=;
 b=X0Ul2BaPkvfCBzxCRL2UXtl/Y/SnnKghcQpn4RpRKikfhsTrANTVZjByPFX8W/bwt8AA2y
 KLlhYb9Yad+yvo2+6p0EDtxzvpxbSziK2OxiL406kMhD5zp9VrrjL3ddilkS/goFy9y439
 NjF5tbL5/+IGpWNIBQNrnpJ6puTMXZA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-U6gdszbwOuKXKhvizUjORQ-1; Sat, 18 Oct 2025 04:14:54 -0400
X-MC-Unique: U6gdszbwOuKXKhvizUjORQ-1
X-Mimecast-MFC-AGG-ID: U6gdszbwOuKXKhvizUjORQ_1760775293
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4270a61ec48so1052741f8f.1
 for <qemu-devel@nongnu.org>; Sat, 18 Oct 2025 01:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760775293; x=1761380093;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FcwCAzl2Pz0avpVx7jAkFXZuqrxrzUl4WKWSVaClnOU=;
 b=R4YfffWVPmxGn2Gio5PlK3zi/OT+l4dGuDZ2AmqwbAOj38NwoPf8s/ASwhxzXIEmaZ
 smF1K4Hi+xzsdP8tGrEgc6mIIwfsFG9rCpw3zyHZpd36zR754inIK4Y29i3YAU5cjrXD
 lfNTp7PEiWc/0CBzEq2yRKTkT5nKm9mUJTucDRUmMUaqXbwGAZ0XYg4C78vsg1yRM4iq
 smISQxmMl1KErcdDzHVDZYmTLJub7WTmSaq6ePRqgxnduSKtWM/QtanP1mOjR7cG8NVn
 QkVCd7IViMRS+qEyMGDF4RcCjYdcI7rZaxK4kiUj8DXkH/OI1tjINb4MtXG+UfIyeosL
 Pdjg==
X-Gm-Message-State: AOJu0Yz1ekvCuQN6UnWbVQNeW8RBByEgv3tA/uONAlRujXhZONaQe8EU
 36t20bq0OavTif11pvD3pUZU+zSORRR4U+5zFFDMt5/RLtvKsiGlwExKz74TgtTUx5GdKXK+ct+
 faVIfw9etud+lFGy8OnutnmAq/dFq0kPDK3oywOSoiQVHxguRLQqovcKC
X-Gm-Gg: ASbGncskR8rFy/m2BGQIExXd4+9u+HJ+iZ84dYiUMmGdai7ngDUGWFs7CUq8xeTVluP
 EvdfVrMYT5pZvydUDlNQSpYm/6umxK0Ys/O+LC3/zzLP6Zj/5EIdtG6UcUpPYmPJwnkL8p9iApc
 lzS/wKXOLLmI1pLUUM8RrJCWZAXfIuGIOTHMDvXd82On8wsGU2huOY7KzuFhxEalS4an7Tl4G9M
 aS242dcHxZbM7UUGS7o919VewgUGT669Xdpr2YRyD8iQOGGpVUwhKlqItW363JRdixlckkSNobJ
 Rte8IouJ0WCwYgqAxx7JoO4uOZhPjTfksZ2D157dssB1eMgAkggOx6mdkUoDS3orbM0JGj1UJoy
 Rh1MZaKlsK4F/D+LJFpz8OFwQk3xa0HqRtGTlkDnCAa2CY6gWTY48IJCPtli5jdGsHlRqHam857
 xJfQ==
X-Received: by 2002:a05:6000:2305:b0:3e7:d199:7889 with SMTP id
 ffacd0b85a97d-42704d8f207mr4598140f8f.27.1760775292841; 
 Sat, 18 Oct 2025 01:14:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHd8VElMLi7vDR5vmzE0+2zFmAtJOR3pUHeb5wwqz9634kiI/AWKHFy9QrNxg5m98W0omWL8A==
X-Received: by 2002:a05:6000:2305:b0:3e7:d199:7889 with SMTP id
 ffacd0b85a97d-42704d8f207mr4598126f8f.27.1760775292436; 
 Sat, 18 Oct 2025 01:14:52 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-427f009a78csm3504197f8f.26.2025.10.18.01.14.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Oct 2025 01:14:51 -0700 (PDT)
Message-ID: <2de05b13-f97a-480d-b07c-2a8ffc695c21@redhat.com>
Date: Sat, 18 Oct 2025 10:14:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/scsi: avoid deadlock upon TMF request cancelling
 with VirtIO
To: Stefan Hajnoczi <stefanha@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, fam@euphon.net, mst@redhat.com, kwolf@redhat.com,
 qemu-stable@nongnu.org
References: <20251017094518.328905-1-f.ebner@proxmox.com>
 <20251017175433.GA14295@fedora>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20251017175433.GA14295@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/17/25 19:54, Stefan Hajnoczi wrote:
> On Fri, Oct 17, 2025 at 11:43:30AM +0200, Fiona Ebner wrote:
>> Changes in v2:
>> * Different approach, collect requests for cancelling in a list for a
>>    localized solution rather than keeping track of the lock status via
>>    function arguments.
>>
>>   hw/scsi/virtio-scsi.c | 14 +++++++++++++-
>>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> Thanks, applied to my block tree:
> https://gitlab.com/stefanha/qemu/commits/block

Thanks Stefan; sorry for the delay in reviewing.  The fix
of releasing the lock around virtio_scsi_tmf_cancel_req():

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 9b12ee7f1c6..ac17c97f224 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -1503,6 +1503,10 @@ SCSIRequest *scsi_req_ref(SCSIRequest *req)
  
  void scsi_req_unref(SCSIRequest *req)
  {
+    if (!req) {
+        return;
+    }
+
      assert(req->refcount > 0);
      if (--req->refcount == 0) {
          BusState *qbus = req->dev->qdev.parent_bus;
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index d817fc42b4c..481e78e4771 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -364,7 +364,11 @@ static void virtio_scsi_do_tmf_aio_context(void *opaque)
      }
  
      WITH_QEMU_LOCK_GUARD(&d->requests_lock) {
+        SCSIRequest *prev = NULL;
          QTAILQ_FOREACH(r, &d->requests, next) {
+            scsi_req_unref(prev);
+            prev = NULL;
+
              VirtIOSCSIReq *cmd_req = r->hba_private;
              assert(cmd_req); /* request has hba_private while enqueued */
  
@@ -374,8 +378,20 @@ static void virtio_scsi_do_tmf_aio_context(void *opaque)
              if (match_tag && cmd_req->req.cmd.tag != tmf->req.tmf.tag) {
                  continue;
              }
+
+            /*
+             * Keep it alive while the lock is released, and also to be
+             * able to read "next".
+             */
+            scsi_req_ref(r);
+            prev = r;
+
+            qemu_mutex_unlock(&d->request_lock);
              virtio_scsi_tmf_cancel_req(tmf, r);
+            qemu_mutex_lock(&d->request_lock);
          }
+
+        scsi_req_unref(prev);
      }
  
      /* Incremented by virtio_scsi_do_tmf() */


would have a bug too, in that the loop is not using
QTAILQ_FOREACH_SAFE and scsi_req_dequeue() removes the
request from the list.

I think scsi_req_ref/unref should also be changed to use atomics.
free_request is only implemented by hw/usb/dev-uas.c and all the
others do not need a lock, so we're fine with that.

And QOM references held by the requests are not necessary, because
anyway the requests won't survive scsi_qdev_unrealize (at which
point the device is certainly alive).  I'll test this, add some
comments and send a patch:

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 9b12ee7f1c6..7fcacc178da 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -838,8 +838,6 @@ SCSIRequest *scsi_req_alloc(const SCSIReqOps *reqops, SCSIDevice *d,
      req->status = -1;
      req->host_status = -1;
      req->ops = reqops;
-    object_ref(OBJECT(d));
-    object_ref(OBJECT(qbus->parent));
      notifier_list_init(&req->cancel_notifiers);
  
      if (reqops->init_req) {
@@ -1496,15 +1494,15 @@ void scsi_device_report_change(SCSIDevice *dev, SCSISense sense)
  
  SCSIRequest *scsi_req_ref(SCSIRequest *req)
  {
-    assert(req->refcount > 0);
-    req->refcount++;
+    assert(qatomic_read(&req->refcount) > 0);
+    qatomic_inc(&req->refcount);
      return req;
  }
  
  void scsi_req_unref(SCSIRequest *req)
  {
-    assert(req->refcount > 0);
-    if (--req->refcount == 0) {
+    assert(qatomic_read(&req->refcount) > 0);
+    if (qatomic_fetch_dec(&req->refcount) == 1) {
          BusState *qbus = req->dev->qdev.parent_bus;
          SCSIBus *bus = DO_UPCAST(SCSIBus, qbus, qbus);
  
@@ -1514,8 +1512,6 @@ void scsi_req_unref(SCSIRequest *req)
          if (req->ops->free_req) {
              req->ops->free_req(req);
          }
-        object_unref(OBJECT(req->dev));
-        object_unref(OBJECT(qbus->parent));
          g_free(req);
      }
  }


Paolo


