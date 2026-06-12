Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33DF3CD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 16:17:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY4ZB-0001kx-VX; Fri, 12 Jun 2026 12:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wY4Z3-0001jq-2V
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 12:17:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wY4Z1-0001dA-CG
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 12:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781281017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u6CunMj2d0uUtUd04hrxqrEzEhaxszuG2OebnVgnXr0=;
 b=XYmR7iKfdMqU86QYi1dacKzT7XSI8Uo8UxH6jbvCu/GqAWaLRDC8q38J81qQRQUKNNk8uP
 aL7o+Ma9NgveNTR9kr68nOGsw93uVm3GkMWHcHcA4ecW9VyIV9AwhgDuAReNxpQmJ1MVMc
 x1x5KaM0f8AGLVS8jd82dMToMTHGZtQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-_ZoFotwsOiq_eC3o3QT81g-1; Fri, 12 Jun 2026 12:16:55 -0400
X-MC-Unique: _ZoFotwsOiq_eC3o3QT81g-1
X-Mimecast-MFC-AGG-ID: _ZoFotwsOiq_eC3o3QT81g_1781281015
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9159c4b210aso176853585a.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 09:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781281015; x=1781885815; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=u6CunMj2d0uUtUd04hrxqrEzEhaxszuG2OebnVgnXr0=;
 b=m50iskCMIR8T/HbIt1SO2d8SFZv7rm/FoYBqzP5h2IOzlOhWnSuIYN/RTX/+1Wss2i
 uj8zawEko56Ps7IYpNFF1cm+Bpn8YuEFNvVJsqhHz/ff04KMi9ueXsRNDbQ6q2TLoWYo
 SHBajJ7Iz43L1R4j6Z+0GcrtxBwbi793gMqBK3e9IM015F1gA1HkJm47OBvueC9VJ/HO
 yxdTYJ9OAqx54N9CIoTVic9PbWC/pg/WX6jDzC5p6h61/R0x/FLQagYGysaNoAr+H812
 U3afLheN8SlzA2tQ1jCc5LHfPWXURhN0z2gMuNHtkNmQNVxIVoN3m3RA0Pfcpm2/PiGC
 xsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781281015; x=1781885815;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u6CunMj2d0uUtUd04hrxqrEzEhaxszuG2OebnVgnXr0=;
 b=Y4ZkITq0t5ktzSU5RKiX26hv+OUH1/NXvJraa6003gZR9ITjcVvQ+31ozPr5IiInj9
 2Sf5MSiOAfZ+ZcJoEU70O47xq6MnrZmQ/6MCPt+8T4qOdVBMQstSmBKtrV5i2VFyqjvh
 L0gU03wVeO6qluSL9Nt1xm0c2JkoBxMnw1zGgf9iObIOoqQxT6oHyB5F29IRKg0pQ+1M
 StC65BZ7xLf4qWJKbPKwMjK4Hsvh4wwCu3PezL5jbYzWzTbg86TobKGzV3nzt6uvb+P5
 Ym4VhLSJG1FSccpfbufupd8WPvES4em0ZsIEhCoanpKvTxmQis4lntrpk1r3OrZkyKYz
 CL/Q==
X-Gm-Message-State: AOJu0Ywq9zdkpmG6OPxmR7Oqa2ToD9ijER7c2u4Ytb/yko4FMT98NibR
 jlSJoF1/Bsv2DL6qUbkjJleXxRmz9J69IlD5NSeeRjyTFmR09alxEh5an0KbMxFAoVh96Yd4oX/
 moxh20dbDjDQTe7IK35RAUm/zgdAmWZKH9Flg+e7Uq43iOzKBD57/SA8k
X-Gm-Gg: Acq92OHXAnlBL/KPXmI1/dYtWnPg5rydYzes/34jRIben+OkkOA2KPh7oS75U8++WQC
 ds/4fLVYezdSP5AIvIuKnf8GGxp2JOSimOWn3GGQgmEcmn4hfXllSIs5vr0x7xrammhzihTnPZU
 6p79xsUA2iUter5GPmzNzUG/3iJKPTx+ooNp4iUXdyrRqL0sdi5WYVj6p1fNxsaxZZ9+b/fngW0
 aJHwhVEXv3+/lbaTAmv7D/4rbLKzBO1jvAp4IYFiSSKJZqyiLnhpe8raYvWmw0sJtm1WG3pwKL+
 oW9AmE3TqcfOocOiOPN4gcU5bJCvABQa08+cEXTbYODG0O70Ley880pHuNVuQdoh4LFgdGA8Yvs
 OYLyIc9r2kNmSvWU=
X-Received: by 2002:a05:620a:288d:b0:916:5f5:de22 with SMTP id
 af79cd13be357-91619dfb646mr515348785a.12.1781281015174; 
 Fri, 12 Jun 2026 09:16:55 -0700 (PDT)
X-Received: by 2002:a05:620a:288d:b0:916:5f5:de22 with SMTP id
 af79cd13be357-91619dfb646mr515342785a.12.1781281014546; 
 Fri, 12 Jun 2026 09:16:54 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9161a00598fsm250767385a.31.2026.06.12.09.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 09:16:54 -0700 (PDT)
Date: Fri, 12 Jun 2026 12:16:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH v3 07/14] migration: Make switchover-ack re-usable
Message-ID: <aiww8tN6dRLA3t_R@x1.local>
References: <20260609075812.32067-1-avihaih@nvidia.com>
 <20260609075812.32067-8-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260609075812.32067-8-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Tue, Jun 09, 2026 at 10:58:05AM +0300, Avihai Horon wrote:
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 4d8b15d99e..8219f13779 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -43,6 +43,7 @@ GlobalProperty hw_compat_11_0[] = {
>      { "chardev-vc", "encoding", "cp437" },
>      { "tpm-crb", "cap-chunk", "off" },
>      { "tpm-crb", "x-allow-chunk-migration", "off" },
> +    { "migration", "switchover-ack-legacy", "on" },
>  };

This line needs to be moved to the last patch, or people will get very
confused on last patch flipping default without caring about old behavior..

After move, feel free to take:

Reviewed-by: Peter Xu <peterx@redhat.com>

PS: If Cédric feels comfortable updating that while queuing it'll be fine
too.

-- 
Peter Xu


