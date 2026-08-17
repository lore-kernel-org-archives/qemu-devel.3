Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3560C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvxcY-0000YW-Bp; Mon, 17 Aug 2026 09:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wvxcW-0000XN-99
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 09:43:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wvxcU-00013r-HA
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 09:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786974197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+QRRMeBTLuMLXzPMa4d0OvtdzR1RWDwGiMgdMVmxBEk=;
 b=W0znW//ULslxbV3jxU/LYmJeBRzli0eVzbZNt1+LoJyrCMPd6cX79MFxZQMS2bwyw5nPmy
 W9BaBs0eBH//0CVF//4RSWAJ+PmnZHurDk6mCUeNhjBx+2D7K/MeFgEWL6gPeT8g0k/Qqt
 frI83PGhjnYw1eLhYr3ECWcDjyFr0S4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-03ZMf-E1OWy2vl0XM7h01Q-1; Mon, 17 Aug 2026 09:43:09 -0400
X-MC-Unique: 03ZMf-E1OWy2vl0XM7h01Q-1
X-Mimecast-MFC-AGG-ID: 03ZMf-E1OWy2vl0XM7h01Q_1786974188
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5aebf128d45so2283327e87.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 06:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786974188; x=1787578988; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+QRRMeBTLuMLXzPMa4d0OvtdzR1RWDwGiMgdMVmxBEk=;
 b=R+4Yc1/oS6QQqpN8504pBBx61jK6qFVsXB/5xvSfdICTLZg5D6NlkY4j4PlxK9R7YL
 uqa1AwytNjHv4dw0gurnhbdn3hu+cJnQWf4/Xc1kQkGSxHA3i35VLNrw/UhAk1DAvcZS
 gphzygNk1D3hEmubqG5GZ1ZTDfLCqBoAayqKKbdmH9sdx0vuLo/bc6ltdQgVRvz6X+oK
 Xs5691OP4026MLJjA2Q+i5dT7XRVtQcwGbV61kQCInoExrfugpO+HyjEGtrPhJHJvJMs
 C/LTGUwlVRbUEo0OgElUiRGLNIPzzFzPbQJdAzqy1AACFqloAMWQQd0iZNZbtXyKPe70
 lpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786974188; x=1787578988;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+QRRMeBTLuMLXzPMa4d0OvtdzR1RWDwGiMgdMVmxBEk=;
 b=eZnStF2cCzo6IzknQkNzHDVZhJO4knjVo5F+Yevzn8tVkkz0gbmipoQ/k7Y64Zlm8W
 uSgaqBXeZXA7Rv/ajjQa/yCIkGu/7IBpvmRf/+IAMNyoMZm2UWonXFi12VYrFWgEAaHS
 NrMLVJBbf16vYk3le5/mFCXnsYGpzAt9iBimWn4IYqDrrKnVGEoWPQLwIVwVrCpseZk6
 1PikecBjJuI5z/sY9Bfm9gUixrBytirps870yHarpv/LQWaZqVnTa48HvXB7eZsLUSNC
 MpWjNPPT6yLH2j6rK9r/SFLwozD2ObxZ/C4/RAIomAWsmrModg/0RwNwn9q5MsENmX5S
 nlbw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrN+7hdOa/qvfEzTpNeAB7aHuHbraSMVhaPzYjhCovO2tIoQs5P2AS1f9VDdxJ7WWRehL3+V8KgDKCE@nongnu.org
X-Gm-Message-State: AOJu0YwcH6igmABYtKDJsTnYFtsZySAR/KqxAY49kGtgnKkMv03CODsi
 LtXXxkNpGxlnclruU6iNdAifmDV9WubdY3QJVTMAofzvA2m4zF7IiPwB1+yLb/Fze0U7k50H80d
 5u/4YbbZgGd4XEiCczlsjfB7eqeRb4lBZwLuWl+AE2WZDgMZP1zyMIMcv
X-Gm-Gg: AR+sD127+I3oTLMrdh2Hhmgp9X+bjvpt0/MUwPGJG6rygkZMPmZd/84kdDuBATjzB+Q
 2cVlcW1tIvlF3w1kSLfY7l3IzB84H0/kXJsBcs9kqt/tHBJI7lwkIe3ZRm//tToAO433n/PpKWK
 0Jivcjv/3jzEwopfXyTgbl1qAW2sW3jSQrkKklA5nzL0uX0GvFVTX3iI2IEWtnji48fqop15M06
 LETZYxlzPijDvqiIXweuTAgAZao7o12ddvx7Qd2ESw7xTyIqNw8PFsth6DQvbOV6CQYvLpTfWrT
 HYF1kOp6QT2bEBgD9WmwNmXKvF5pgtFoko0sh0s1eVVlUzNX46RzI2CunDCHDQu4jGf6ibqg
X-Received: by 2002:a05:6512:8050:b0:5ae:b0aa:fbf5 with SMTP id
 2adb3069b0e04-5b458f684f8mr3512557e87.22.1786974188252; 
 Mon, 17 Aug 2026 06:43:08 -0700 (PDT)
X-Received: by 2002:a05:6512:8050:b0:5ae:b0aa:fbf5 with SMTP id
 2adb3069b0e04-5b458f684f8mr3512544e87.22.1786974187783; 
 Mon, 17 Aug 2026 06:43:07 -0700 (PDT)
Received: from x1.local ([2605:8d80:6d69:f92b:7977:1c9d:4b95:fc47])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b46cf957edsm444546e87.4.2026.08.17.06.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 06:43:07 -0700 (PDT)
Date: Mon, 17 Aug 2026 09:43:03 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 jmarcin@redhat.com, david@kernel.org, pbonzini@redhat.com,
 chenyi.qiang@intel.com, farosas@suse.de, aik@amd.com, xiaoyao.li@intel.com
Subject: Re: [PATCH v4 08/12] hostmem: Support fully shared guest memfd to
 back a VM
Message-ID: <aoMP5-YglB9a7Dv8@x1.local>
References: <20260812201938.198915-1-michael.roth@amd.com>
 <20260812201938.198915-9-michael.roth@amd.com>
 <an1_NmWhtHY_Cf9V@redhat.com> <an24aI4sAILoxncp@x1.local>
 <an29FY93x45qnJuR@redhat.com>
 <tjzytooy2a52jaw3rjhaph5nunc2locecvjh6dp567hdb2qrjs@zmtebtnfpv6b>
 <an8z4xPM6ui0-J2K@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <an8z4xPM6ui0-J2K@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

On Fri, Aug 14, 2026 at 04:27:31PM +0100, Daniel P. Berrangé wrote:
> Yes, if we think we can make QEMU "do the right thing" internally
> that makes a separate object much less desirable. That would
> be saying that we have a tri-state,  guest_memfd=auto|on|off,
> and such tri-state's would not invite a separate sub-class
> design. The need for "auto" rather forces the approach you have
> in this patch.

Just to mention, one option here is we don't introduce "auto" at all,
guest-memfd=on could explicitly mean the init full shared mode too.

IOW, when used in a CoCo context, memfd objects will be normally silently
created with guest-memfds, like what we used to silently create guest-memfd
2nd layer without any cmdlines, but this time when in-place convertable
it'll be the solo backend.  User doesn't even need to know.

Then, when guest-memfd=on is specified in such a CoCo context, it should be
able to make this specific chunk of memory "init-shared", while the rest
could still be in-place convertable.  This may make the cmdline slightly
more flexible to allow init shared also in CoCo. But I confess I don't know
if that would be useful ultimately, and I didn't think all things through.

Thanks,

-- 
Peter Xu


