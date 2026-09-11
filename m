Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCA6C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xAo-00055L-OZ; Fri, 11 Sep 2026 05:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xA1-0003nB-I8
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xA0-0008GO-4p
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XBW41WApnawDSx9a8mqXcCXFaaQqc3qyywi8ob8BaOU=;
 b=N7lUkNnra/ZTSZenYg36zh7m1qE8dl/sgxz37nTSXkm1PkRb9z/MIck4KNIwJtoTpCB+mg
 WAmRFFL52vnV7BFhZ/eL1xPQPchG52+Xsy/bQhknci7u2jdOsm8Exre+IpOupa1PHH4Ozj
 wqCJaFNSqPmJJ94rSGmL4sKWh2SpqMo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-qCfWmE33NN-iZfBPu0Vchw-1; Fri, 11 Sep 2026 05:03:02 -0400
X-MC-Unique: qCfWmE33NN-iZfBPu0Vchw-1
X-Mimecast-MFC-AGG-ID: qCfWmE33NN-iZfBPu0Vchw_1789117381
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49d0ae342b9so5183735e9.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117381; x=1789722181; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XBW41WApnawDSx9a8mqXcCXFaaQqc3qyywi8ob8BaOU=;
 b=B5JDkwdHBoAWGEPlc6hITbIDsFgXR+oyIguuELk77Lb8VjFLz9vT51xIPk4A3Me6px
 J+la4FyyAh/udLm3rdaDhNfS41vBbk/yfP8ZY5/6DpZXX2xgWhNUtnEmC4zlzFE5if6X
 WLqTVeUyWfIvIf3koEwaM6I3BU0Epzvozw27km0S/dBBVjU9SA0KO+Zd7slRw/KvsTPd
 EwLs8bfdU3YSzMqS+Z/6N8DFcPoSJK81WIHu6GELdB4PYjLOtaD/MMPoxCXchnMYwCMo
 IWj5o6D92nAAlff+bekSVoaRHatL/v1pfkuAekz65+lVAziPcqOVVp6cx1G6iBi/kFxk
 gk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117381; x=1789722181;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XBW41WApnawDSx9a8mqXcCXFaaQqc3qyywi8ob8BaOU=;
 b=BI1/rKIEbyf0YgMEpoLsyHc9AzeXJEXp0Xx2aYaECq0yPjTTuY0KRCPdEvWLEFudir
 fdFIknqHE4CMw7AB6uKfarh3zaQq0Fu/zy2JpL/NysEWDQbnUZcg+/TAc2GRv1OwtAAf
 z1u7CfOkqUiv6o+u9ONpd1jhq36MoNDe62zArOGTNFxLWaesFGv0prRkHkzhsXd/DNyk
 PprF27c1MqKoqfVA85JL+1fmsOktrnQklF6pR1mDsdc0oZdxm7lMlAcCftJ26VBBy9PI
 8PBgAf+Ru5OW5lQ9LmoTtI+sEvtGfiKf41VKgo/SDiAmBy7uZJJYtoMGn+exdlUvygtc
 Ny4A==
X-Gm-Message-State: AFuF++kwu9Ql2+tYJuFSS/q4RTZMx9MS7rGhaR4pS8lAmAeLNr2YDID3
 biH/lh9WplYphFDS60WBaLX4GQGfYa3tBEPea3XOkISbwOoUGJgvpyvUtTXhlCSHvB/j22KQvB/
 NQqK1wd+9C2CdyLdzlgA0Z4F/Ga52fGYBTY4o3b2cZ7vVf7JcE7JjHPp/BzKCEkUZk6VTkI37Di
 LOedi/VeHcFNPwMYGbe7keN2+BiGSntXkkIQ==
X-Gm-Gg: AYBFou3yWf9ZyAwmRZ5aenfJ32JJ9DfBDzSvH98IGvoKq0HapGrm/CEYoG/Oueu9Vo0
 8zM5DwkF0pON7Pw26a3krSy311FdPOdYwXpR4ceQWBGPLU/e42e5jOPCl3IxDOEeWV+smbKIDEQ
 BJNo7NLyZmxqIjecxqg2m6gW1UdgwtxY83jx80wL4dUTuvKWscMbgb4LWZAMK0e+S8quFl/794/
 PVMrseh4rbi6v9wK5ur1u+GL9hJRK5dAi7ebupxBFb76ZMc4WDeW+oeNQGUb08gK+PPXcsuvOxZ
 qhJatcOd3qQiMregzYK4O6EsKAE//lsYKE+MMg6BTm7gcntx0rrtJCdl3Tnd51KmyFs3HAtVJCi
 IMdn/1fyRe0m7CgW9cHO2ux8=
X-Received: by 2002:a05:600c:4703:b0:49c:fc6e:a3d7 with SMTP id
 5b1f17b1804b1-49e619bfdd3mr31900385e9.22.1789117380724; 
 Fri, 11 Sep 2026 02:03:00 -0700 (PDT)
X-Received: by 2002:a05:600c:4703:b0:49c:fc6e:a3d7 with SMTP id
 5b1f17b1804b1-49e619bfdd3mr31899625e9.22.1789117380148; 
 Fri, 11 Sep 2026 02:03:00 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e636f7fa2sm38792325e9.15.2026.09.11.02.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:02:59 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:02:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alyssa Ross <hi@alyssa.is>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 42/75] vhost-user.rst: fix typo
Message-ID: <1a166f44eef46b9ca46f5950526c2ee79f1e019d.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Alyssa Ross <hi@alyssa.is>

The protocol feature is named SHMEM.  SHMEM_MAP is one of the
requests.

Fixes: 588acb45c2 ("vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec")
Signed-off-by: Alyssa Ross <hi@alyssa.is>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260804121000.444745-3-hi@alyssa.is>
---
 docs/interop/vhost-user.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index ae8c7ed995..fbfb9d01c6 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -1158,7 +1158,7 @@ Protocol features
   #define VHOST_USER_PROTOCOL_F_DEVICE_STATE            19
   #define VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT 20
   #define VHOST_USER_PROTOCOL_F_GPA_ADDRESSES           21
-  #define VHOST_USER_PROTOCOL_F_SHMEM_MAP               22
+  #define VHOST_USER_PROTOCOL_F_SHMEM                   22
 
 Front-end message types
 -----------------------
-- 
MST


