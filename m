Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6177CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 16:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPjSd-0007wH-LJ; Wed, 20 May 2026 12:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPjSb-0007w8-OV
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:07:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPjSY-0002Tf-LW
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779293269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p8m5XcUbhm1brJSG2oG1B0Zn+D7Dr1la3H7WyrJngiA=;
 b=Gx08fxNdHuTYmRSRnE0GGx+t9IYvRpCh0YCMogQkuHR5HTahlVJDaASTg0tHUZStU2NIbC
 tWBv8GQF9IztSeGD9EpqZUqO3wv2HhP4/hv27HFT03+EQjMSEbMI/+aeE01aPDcvBIgvk8
 mlsgou5MXFGhp2uSYoWexlWYDJXEFZc=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-GURII1pDNR6WhdjK9AqViQ-1; Wed, 20 May 2026 12:07:48 -0400
X-MC-Unique: GURII1pDNR6WhdjK9AqViQ-1
X-Mimecast-MFC-AGG-ID: GURII1pDNR6WhdjK9AqViQ_1779293267
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-63271d633b5so3604131137.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 09:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779293267; x=1779898067; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=p8m5XcUbhm1brJSG2oG1B0Zn+D7Dr1la3H7WyrJngiA=;
 b=HrfQPGi9AqNPXjnVKv9Bx6pvsaGHjd/rNWg0X5v+eLxprDH74F0e4xQehfW5a9MQ8o
 tOHmdTqc6jfPD/OM5Unb8wQg9zNGyZzbwH7BurtF/AonlUwI8GRbqBoaM1l3n7LM10gq
 xD7kpGjxj7MRNuIToJWyNGlA07YyJSD9tResjU+unnTTPrpQMsdhd5GKw31zHe30MZvx
 zPghh2MAg+BBTzXbzJBzdGIS/xfyvbfJ2mUmX1X3tA9nPFs82AXEkroOfPZkws3COmad
 ThidOiyvkbz9aJjefD3qRcWqfHOe0qm4n74MnQuEw5ZWZ4P3s4z8n4QQ24a+tYt3b0vj
 ESzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779293267; x=1779898067;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p8m5XcUbhm1brJSG2oG1B0Zn+D7Dr1la3H7WyrJngiA=;
 b=JDPna6sHsePDmrXEwBK8wMnDFSf3EWlODilKBKfvuNnParbIjoiTDJl2SzMCEh3eO9
 FJOlVo689zWNq1DQsMHenA/vY9arxUiz2fqvhNZGyDiAGUJE7ZCPcQWTjaXpvF19nqj/
 G1AwDf8jeLgRsnOfmFLn35AE+NT149GLJD4Onj5Na744G3zhNuUFAiqm/B8UQsEPrYrK
 RzV7stXSIrG2eiEXYiS4v+cPmOfkf6O2hyPTy5GyBsdeVAxF7FMPyeS/74oANuFcSCOK
 DszB9fgVw/ZZeUCij6W/soXwHNbfZu1rop4AY6KVhwxXg055+HcL0An9waQakh4SBE5n
 PRdw==
X-Gm-Message-State: AOJu0YxT9qEauF4EDhhIAZ5J7tKbRxKR0w9CvugI53cTfGlYDef8N00j
 Bl3/5Vc6fnkzO5bgqBR+vJmhC9ccoROQIvQhreaWWT0mS5J3vwCfD9+aY9xq6Xa8ioMSyF9oAN6
 KaI7b2m6ojLG1bwNsF6FsGm3PvC7kzfE97x2Bijz+7aYZGrAJVj6CFg/S
X-Gm-Gg: Acq92OGSA3ag00kOJzksx9xBMggJEGMQlVPSv2BjU1gWKwbctfmo7GJXZK838hvHruI
 rUKbr6oRT2EKv9JQA5+mIZjANWCfpfnz3wAHzX5SEE5qGre/yIAnSCw0lHUUR89yuP2YkKPjaUI
 vBHqLa+oqOvM9rJ96W4SWxc3s/tjVCP6Hn+g0Adc8aejVu3EgUQmIXhcKAMr1Ye93Xz/CFOXxEZ
 5Q1Rho5tPxB7KLIlBz0sybxfLKw7oOLZ2nS3kkMUdQBepG3vrHnGvlsv2am4amzsxUUH3Fn6S/l
 CeqqIEHoh4fIyJGI917sPuxgHywyONrBXo8/EGQAyj2tgwhjssa0SN4qgrrmE7MhvTv5jhe1xt0
 UeWQywU6RfD1iFui6PFEJaQQBUifzkYUo+Y3b4xCAhN39w0I=
X-Received: by 2002:a05:6102:6886:b0:631:4580:6a3f with SMTP id
 ada2fe7eead31-63a3d6298dfmr12700363137.7.1779293267281; 
 Wed, 20 May 2026 09:07:47 -0700 (PDT)
X-Received: by 2002:a05:6102:6886:b0:631:4580:6a3f with SMTP id
 ada2fe7eead31-63a3d6298dfmr12700283137.7.1779293266705; 
 Wed, 20 May 2026 09:07:46 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910ba463814sm2161832885a.5.2026.05.20.09.07.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 09:07:46 -0700 (PDT)
Date: Wed, 20 May 2026 12:07:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 06/15] tests/qtest/migration: Use a default TCP URI
 for precopy
Message-ID: <ag3cURRpHTe4AZe3@x1.local>
References: <20260505160915.25558-1-farosas@suse.de>
 <20260505160915.25558-7-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260505160915.25558-7-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 05, 2026 at 01:09:05PM -0300, Fabiano Rosas wrote:
> Using a localhost TCP URI for testing is quite common. Set it as a
> default for precopy tests that don't provide an URI.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


