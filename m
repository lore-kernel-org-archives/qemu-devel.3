Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BE7E7718D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQB6l-00015A-I1; Tue, 24 Dec 2024 15:02:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tQB6i-00014k-Ir
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:02:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tQB6h-0001gs-9V
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:02:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735070538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iHRSL7g1qaxeHGQpwU5xzhSki/QEOcFt54VgH/4iZWM=;
 b=Ir0w0YIQ+Um8AR1ug3oOquGozXZjLDWnPJ0FtsX4bqkBL+NnVG69zDuNi0otpUHwg5nsWX
 j73sFYo2Cp624Ykujw9SbHDn7GnMWE8BtzdCwhrrGAydiVbzweBK1yTANNahJS7Ulse9YR
 uSCGgNw0Iu7KrSrUspqYeBDTb5BH2As=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-lTfxXY-3Nb-m9W5vrkRYcA-1; Tue, 24 Dec 2024 15:02:14 -0500
X-MC-Unique: lTfxXY-3Nb-m9W5vrkRYcA-1
X-Mimecast-MFC-AGG-ID: lTfxXY-3Nb-m9W5vrkRYcA
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d89154adabso101381516d6.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:02:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070534; x=1735675334;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iHRSL7g1qaxeHGQpwU5xzhSki/QEOcFt54VgH/4iZWM=;
 b=mHen+BH3xEKjDTAwrpJNyZk+Ekh53BTsaqfiMWrrTWWg+BbzEpPB/9xRHPQPbGG3FR
 v0EGdddmhmK4P4AZ8cnQWl/6I5Lsf26jzTxJoHSUg+uZseqL/Ov2rGqye6XeH1UfvaVI
 d5aQu8wnXR/yTaxTs2Cse7u9EpFQJqHuf0jlIpz++NVrhtZlA5GcuBekUPrf8XZvBVMl
 jRrGiSKvLtgB9PXOO6e0Qt+af6a9EdCEfdWdr9fEe10RUIpvfjn2p7Jo3duRWiYbc6Ls
 Cp75Mve28tO+LGCEPQ5HQuIAYTkrUzlYjR+e+1+PsFVvZrte4gAFk063RtfWSGl6g3Mr
 /00w==
X-Gm-Message-State: AOJu0Yy4UnZOBse0Tka4K/0Lj4ve4d3L2fl+yE0M0A9PHk6iFUSEFcsH
 4r+H8smBLE9P9uynJjjMILe+LfzciJXe0M8/ZK2Vcv2Qppl/eChWcvblSDUv5Bv+xMMCw6xXjtN
 l8YSp6kftjf0INaEzTYYCBCjxUhF9S5jHRLL947zHOQT4VLU+y8Z2
X-Gm-Gg: ASbGnctC8Sq6n9d7f0rU1UKxtMV/zpS8DHJ8Pw1REejhEcGhb8uGySXd1b7XaocjLc6
 y7QsiHzwcgzw0Tu3yjDcRrB+xVfbEArwBw3PV7fqVKk3gTrhZFRn2pjUnCqymBjEvk2tHWBmhTQ
 IbqDoRRjwmQrvX48ei8SmPeNLBRxEwophJWHzJgref8YxnmioL1R5jVxx1y8oN76+6cP+42PsMI
 dTfhTJPti/NPK9WNWUpT+rh7MSQSSXByvCo8aoJE/yNPOp7hiZ51EYDkaHs2OcEQ1Xu4eHvlCZR
 T/F+P09eXRLpC4sHYg==
X-Received: by 2002:a05:6214:238c:b0:6d4:243f:6c9c with SMTP id
 6a1803df08f44-6dd2330c5aamr331907726d6.9.1735070534243; 
 Tue, 24 Dec 2024 12:02:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAdLidTJkne0t3YPtZV7iPCwBPzvvvhJDau/Q6W0RqNHSeLQmqIlJqAIpJDvmSaqXyTXxNpw==
X-Received: by 2002:a05:6214:238c:b0:6d4:243f:6c9c with SMTP id
 6a1803df08f44-6dd2330c5aamr331907486d6.9.1735070534007; 
 Tue, 24 Dec 2024 12:02:14 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181d5308sm55577016d6.111.2024.12.24.12.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:02:13 -0800 (PST)
Date: Tue, 24 Dec 2024 15:02:11 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V5 23/23] migration: cpr-transfer documentation
Message-ID: <Z2sTQ6KHmh50QENV@x1n>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
 <1735057028-308595-24-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1735057028-308595-24-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Dec 24, 2024 at 08:17:08AM -0800, Steve Sistare wrote:
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

(Not suggested to have empty commit log; can say something!)

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


