Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B6CE81BDC
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 16:14:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpTtA-0005fj-RL; Mon, 09 Feb 2026 11:13:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vpTt9-0005b5-CT
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 11:13:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vpTt6-0007li-I7
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 11:13:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770653603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0Pj7g/cskzAAzs61O/JI9obuoZ1m6+4efYqE9B4ss0A=;
 b=K39Wbc9kTaCgEJeGUnBscJ+QrhhkubficTOagb2uLxTtrp50zbgTbx52uenTdtMSm+SQp5
 5o/VDamBa//nPENaKr9k0FJqNXubjhNATHpvp7buK4gA81TKXJB5zJ1+XJ3qr6zfETkiz+
 n4S5+M1k3zh3npjxHdEOFN7Sr77f42k=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-Te3HUnRdNcah0V-DBJUykw-1; Mon, 09 Feb 2026 11:13:21 -0500
X-MC-Unique: Te3HUnRdNcah0V-DBJUykw-1
X-Mimecast-MFC-AGG-ID: Te3HUnRdNcah0V-DBJUykw_1770653601
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8954c8b3d61so56259546d6.0
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 08:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770653601; x=1771258401; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0Pj7g/cskzAAzs61O/JI9obuoZ1m6+4efYqE9B4ss0A=;
 b=miyuMkKjpuuCBNeGZeuhs8XGF65bP2+gMZSds4kOJ/4Sn98jJkxnF9FFeitwY1JXKM
 lfQXuokDj1MZqd35/KBDvG/fjSNVzNKlLseTVPrnq6FruFSUqEDCEYBG7vN1TH6aJRpI
 hjQmYeUF8/N45DWth3hMZPZDjxOayTaax77LUudVVfbgZmB2reiGAuVAfv5VX/gMiU+V
 LsIkqdP4Izv1tWLYFoP/jBbc5m3xKWmIVCveASNa2OBsExSIGM6zFVjXt4zZdV2+I/fp
 2QwRr2Ou7hwUaqsbeXB0ohjKYITf90Rq2bCleW7lHeVGgPQPJlZtus3qXJLw/mMjMTK4
 yfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770653601; x=1771258401;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Pj7g/cskzAAzs61O/JI9obuoZ1m6+4efYqE9B4ss0A=;
 b=lM7DOUp9/xBcXluA8tYhu4MKq+8NWSWCTVJbG4mt+zdRRaYFQteCi65twXzb9rxWJ0
 tVn5yHZjvxpG1BPNUp6uOhrOKF5pJBEzQCLPAljviYyzFcblUMjUYNnDADjoE0tw6lAr
 1oRjEjtLI5kIr56t+i178J+y/vnYySoFINu49pHaO7mUHTFQIf9BDuSriFLh/yQ6m3oV
 8i5triv0nFv/gBqrHz+l2wE5DhgehetzGx+RBzCcXDCQez845zbu0Ru60BMMH57tY0m+
 BRnoCq8nCFtyQp/7bP5+uDP0IgFAu7kTOe/9RW+4ASpcKxdaMbHvRC96N+PGk0RIH9ZG
 Q7sg==
X-Gm-Message-State: AOJu0Yz5ToAzgRMzgOeHI0XMDQe7njVYKicgu7gUeWq1EURso1W7hFsu
 aRkcyhdnSBg2Q5b9jzLivam0FMmWM8Eidg/WwTzESSI6+Kwza8FpwdUNGOW+5lIcQTtIp7nqxn8
 XgSWqA+4p54yDTsV0LRKp928zv1P3DHE0r497MNKJ3a4y3JYOANwr/SSN
X-Gm-Gg: AZuq6aLn4ONwwSjgAOegO1JEr1cgRJS8k8wnHxnmZytjyqLzNmJy+jzPa/wei2QKN8b
 PvqHOqgha3C1EIZiIQPgXVfs1Irm5GKc/+WybkhDWQnLhUrBL0OWvCOUUwLxOSeSm2rfUa+nbcI
 7bpIIv0W7dDVKJ7Leh36JR8OQ2X7Gs0iltmLvgodGlMDyTKVl7bsF/cgSXGl33OIBG1uXBREZIf
 YQwjTboQr8nDsQv8Dxw/RMCAo+xTJZ6KhN43hscKjZjOOcHS2/03fmBx0nAGosTDls34AuTJ/2Q
 ZxlitLR5Egr7nWQnUmlKL3ER5KN4PJ1zXoVamm43zPdvS0Kdzuhb+lIpHh2+2nqq3OZZF8BQKde
 dbAE=
X-Received: by 2002:a05:6214:21ae:b0:896:f3d3:4f8f with SMTP id
 6a1803df08f44-896f3d354e9mr88534946d6.3.1770653601280; 
 Mon, 09 Feb 2026 08:13:21 -0800 (PST)
X-Received: by 2002:a05:6214:21ae:b0:896:f3d3:4f8f with SMTP id
 6a1803df08f44-896f3d354e9mr88534476d6.3.1770653600813; 
 Mon, 09 Feb 2026 08:13:20 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89546b09efbsm64123076d6.37.2026.02.09.08.13.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 08:13:20 -0800 (PST)
Date: Mon, 9 Feb 2026 11:13:19 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v5 05/16] colo: Remove ENABLE_COLO loadvm command functions
Message-ID: <aYoHn5DSsia4mxMW@x1.local>
References: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
 <20260203-colo_unit_test_multifd-v5-5-57508b7389f6@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260203-colo_unit_test_multifd-v5-5-57508b7389f6@web.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Feb 03, 2026 at 11:15:11AM +0100, Lukas Straub wrote:
> No need for it anymore now that x-colo capability is required
> on incoming side.
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>

IIUC this patch needs to be squashed into the next or it will break COLO..

-- 
Peter Xu


