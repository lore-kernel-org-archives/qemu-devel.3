Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F451F436AB
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 14:05:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDjok-00055P-Hx; Fri, 17 Apr 2026 10:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wDjoi-00051g-CS
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 10:05:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wDjof-0006AX-KV
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 10:05:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776434703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LxSHP6Xe6L3p5zpTwc7n+O9JU76cgmgHEJWzQL5MrXg=;
 b=THBEDJcVmajHLpFV3n3Mqq708NA8F+DABkd/m7gLLhTBSkDVR+9jdy6O+wXR9y1iGsYlL1
 hlPCXAaJ6s/EZN1qkbNsMVN0ANbKIqwfVbJDozFkFl2Lwwdecb4Sdw6pvH683GMAW8EW5P
 catcE33HEVRkTjEzgjZkZ9mfZI17vUE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-f3_YwFwIMR--otNiUfUvZw-1; Fri, 17 Apr 2026 10:05:01 -0400
X-MC-Unique: f3_YwFwIMR--otNiUfUvZw-1
X-Mimecast-MFC-AGG-ID: f3_YwFwIMR--otNiUfUvZw_1776434698
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8d3e4c19307so134533985a.1
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 07:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776434698; x=1777039498; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LxSHP6Xe6L3p5zpTwc7n+O9JU76cgmgHEJWzQL5MrXg=;
 b=bG8WpnDtgkOGpcd/uHB4klAxXJlV1tB1rHwfHMyFfgaCCGLH7FnuGb1acICM/ui6Wk
 f05e2+q8uNk77O4gO+NYnRGCV6LRv/bqbXQukBKMktgU6PR3+2pnTBVJVVnItwScKBFH
 K01r0JVp1k2IjSj5tei3M4K0SgPgtVfIvwCFfsbceHMsk5CT96D2oID0872Y8syRBisx
 EjmQ+NoxT+FWVrKkRz31vIIEUxx2se57A7LqThgD5c1RLihakEfjzUlzxX1qGLW4bJxd
 qJ+xQQztAD9sOqYJ43rTEunNiiH2k1gQpjaLT1LR3pmHfOMLZPK6QewvV9jEoBtNBaC9
 QylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776434698; x=1777039498;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LxSHP6Xe6L3p5zpTwc7n+O9JU76cgmgHEJWzQL5MrXg=;
 b=eLQwoOpXcJiF15aZS353CvGHbrKsUzUG+3N08cgtaTZGsr3XRBi6afjkbvLftVW+G0
 JmRlXbE0Qyq3tvBZS0PLcFus2SjyjEa8VBaZeiCDNjwa6YUJ8eZ0dTHVHxzb6easklHP
 1JzVPSYg6VVdfHI0lJfSnBbmxejj9iQjnVfdycce3V1cxoY8NqZ0qC8oKYCiVNJ6mDMw
 i8hkL+wf+7LS4ofjXEsR2QrWbzej/Hfj3VfMhAC34OarqQokjTGtMijwA9JDGJHOfBvI
 kTDwnkYWfsYyLSBqvV1l3Qm/mRgpmgor4/vOBH9j4JTWCiE/W4sOqljfVxanCef32ALe
 VOYw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9jpH886dGZm0Zc0YPQFRylrBZkQWd8dgfE6aMD2HrrvC328t0Q50zztPismWbQFgUzBr3a34h+T0XY@nongnu.org
X-Gm-Message-State: AOJu0YznjCeb6y2FXvzF7HMs+d5ARpvTZHFGgeCO1lB+NWxpFt7AxV5T
 0OotuJABeYTIvjztQ5X0z4g0YQzE0vtxZgizYVz45M14RVY019uEye65H+0Erir7KZGaajr2LFg
 jUzk/lnFAn8wlX0mkjTX8xYRfp0/JxPVHs5LWc6dDVLT5PK1AU1Cz88jC
X-Gm-Gg: AeBDiesF90J8a0JSoNtH8R7VBA2bAJL1kXQ4+yUCzhLr7gmWyefta5hiPxsJmFWk/s/
 FOGEZmoHpvARG9AKq4a+VLVb1oDJ8950rtm/vrPHQ7OVY0lE+xzMYZFAlLvE/ljblAbLC3+p2Xk
 IcPk9pxIsrK+XCFUHYtzXumSwPMJ0VL7/e4sWjF0kSx0jFUFwfJt1E4y/9ZoTrq3+RkTzDef5MJ
 Geiq6SHxDBoF4eWRI9pcPVwGZERBZZvAPJuiMI1teCW0S+yt2gxfICgC41G4eiWdvvSxDTvBXFo
 psYDEwWgtUAfCZnHX47EYWmik9v1arNHsWbmz0ZeyKwECUzbhP1jMARnWAckm5R0vrvi0bKYt95
 89MyYmrWwe8m1QdM14/Hc1YpK1I+kMdF7plaqGBSur4DCmzp+LtAoSZ7bTQ==
X-Received: by 2002:a05:620a:45a0:b0:8cd:b317:a0b4 with SMTP id
 af79cd13be357-8e78fb19171mr426479185a.27.1776434698008; 
 Fri, 17 Apr 2026 07:04:58 -0700 (PDT)
X-Received: by 2002:a05:620a:45a0:b0:8cd:b317:a0b4 with SMTP id
 af79cd13be357-8e78fb19171mr426473385a.27.1776434697424; 
 Fri, 17 Apr 2026 07:04:57 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d5fe8edcsm120070485a.6.2026.04.17.07.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 07:04:56 -0700 (PDT)
Date: Fri, 17 Apr 2026 10:04:55 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Junjie Cao <junjie.cao@intel.com>, qemu-devel@nongnu.org, farosas@suse.de
Subject: Re: [PATCH v3 0/4] io/channel: complete pread/pwrite_all API and fix
 multifd_file_recv_data
Message-ID: <aeI-B3fna39LXklj@x1.local>
References: <20260413214549.926435-1-junjie.cao@intel.com>
 <20260417165155.7714-1-junjie.cao@intel.com>
 <aeIB8HvFb-sJp1NP@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aeIB8HvFb-sJp1NP@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, Apr 17, 2026 at 10:48:32AM +0100, Daniel P. Berrangé wrote:
> On Sat, Apr 18, 2026 at 12:51:55AM +0800, Junjie Cao wrote:
> > Hi Daniel, Peter,
> > 
> > Just checking in on this series -- does v3 look alright to you?
> > 
> > I have a follow-up series that depends on this one to fix the
> > remaining positioned I/O call sites in migration, so it would be
> > great to get this moving.
> 
> I've ackd the io subsystem patches, so Peter / Fabiano can just
> include them in a migration pull request.

Junjie, sorry for the late response. It looks all good here, thanks for
your work!

I bet Fabiano will pick this up for his first pull when 11.1 dev window
opens.

-- 
Peter Xu


