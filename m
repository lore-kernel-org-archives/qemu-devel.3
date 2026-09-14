Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDBCC88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 20:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6DNz-0002VD-Fx; Mon, 14 Sep 2026 16:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x6DNM-0002P1-Lc
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 16:34:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x6DNK-0003se-JE
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 16:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789418041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BNeHt2nl+f0teVkOVRkSIYutF56Z37rlkIqDKy+dx6c=;
 b=GJLVYiiCRNxsiO+h/p6z5zA+r0egSMaiEoZpM/muUjA9sbW2yJcZmr3dUTCx9m1qcLWzbF
 2HTDkdb+LmKEfChaN5zBfG2CtF7013HY6WmRZB6gurcZlstDz4xVdL9o4FJP1cmLh7PJF2
 E7PbT8UussVF4+Fe+kvMvY+hdzgy4m0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-6F-5I-hxNh-e96V93TAD7Q-1; Mon, 14 Sep 2026 16:33:59 -0400
X-MC-Unique: 6F-5I-hxNh-e96V93TAD7Q-1
X-Mimecast-MFC-AGG-ID: 6F-5I-hxNh-e96V93TAD7Q_1789418039
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93a1b824e84so314824185a.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 13:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789418039; x=1790022839; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BNeHt2nl+f0teVkOVRkSIYutF56Z37rlkIqDKy+dx6c=;
 b=loan5uoeS3AzYPQNvtvPWvodoBGoV+IP3MBNORCpEhzT08j3YTbYhxZCeA/9/KzJXv
 0/TxGV0Yw0CN3d3DFiI3hmmGQJtV87qPIcU4G30HVV5Atr23JS93PutksKPqoCW5HjoH
 mrbWufzeGtrCJvdErD0UrV/bo7vmdljmaFXRJ6D8+cc/TejIjjHRwnMj5KLVruMSW8eQ
 805AhRXYesbzi8wr+n8bFJMkUKp8lm09AXe19hEjH2opR5fhmPGTae65d8qIzcVtQ3qM
 LoW3lm/Qq8xLu9V4qOXboU1Oj9O2sgVO6fwKPtf7mxDdbRa2DVhC+Mx3FCRjE8MXHeuL
 fGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789418039; x=1790022839;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BNeHt2nl+f0teVkOVRkSIYutF56Z37rlkIqDKy+dx6c=;
 b=c8xCd0dRHOj7uD0+t5q47M4OZzfUSxdRRwol+GCLZJS6kn6/j1E0Dd9C9TPDw4pL7D
 rphK+FK8jL4p9puwTYODtH29+gBQk6HbPMlG5FnBibPeg+6hWLV+cHYnBqdyRFMD46+S
 zdykWIhRgg6Hj5VBHDbVDd4xHueK6ZFqPK9gnq90BJJUzFm61ZtW8aVFDc9MrCp7Bkz5
 w5LuntRDQFF29H4j6sOlFkoHnzvP5w68AMZ5kjm3oQS1m8s6r4NOVdT/Pfd2SVG1ueYe
 FFGjxDwpv69j4rYktFXpcJjfCUwR3k+taMa86SEv/XoPFe/UiVqtC2JWjLC55RH4xf75
 jMnA==
X-Gm-Message-State: AFuF++kwaoFm41cDJaD8aMYwEQwU8exSlZgQxo/6k7lTY0p0hqWSmyjR
 hUjOQHELUoIvuTkRgBUb6ToEnAe4UlYz0y04YnREW3jYn05Vt0AUeaEhDYNhdzttr37Ta60oFos
 ncZj64v5MwPKvcXbygQToqk5vsIpKtBFyc1PVtbgfolG9eg0vIBuLZ34o
X-Gm-Gg: AYBFou1Mc2/nWHYxEYYFyuEV8YWi+t7qNS5hOgWDhiHZVsKvoK+bx8E3rvV59siPs7q
 3BIPjpaKksiAQzPtjka6sx9am4zblEXU8EgodvUzVetQtL5JHRqYr6azqoNrdD2z2vNXAKnEobY
 PAS6dsjDZqoT+fDBSkAOCbT01GGpnCGvsDowzekpAgxFWKEdeE3xn+Z1TsG7dEDr8AkL3Hs8gl4
 l5ZLfy5T4rXAJIm/4GgHiIymq2sNoXn/Ts4/GEK4fGuYWTzhkRRXJQsIDG59b6bn02rTSaKsCL2
 6ufl4YFtbieiVmQG7zu5Ft45YRLkY8AqCc9NdFeCR8RnaUL5nScgJVFyYNVV5sUhgDva
X-Received: by 2002:a05:620a:460f:b0:93a:e8b:2df0 with SMTP id
 af79cd13be357-93a299efe8emr629730585a.40.1789418038990; 
 Mon, 14 Sep 2026 13:33:58 -0700 (PDT)
X-Received: by 2002:a05:620a:460f:b0:93a:e8b:2df0 with SMTP id
 af79cd13be357-93a299efe8emr629724785a.40.1789418038495; 
 Mon, 14 Sep 2026 13:33:58 -0700 (PDT)
Received: from localhost ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939e7f18628sm1077639485a.13.2026.09.14.13.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 13:33:56 -0700 (PDT)
Date: Mon, 14 Sep 2026 16:33:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH] io: cork TLS writes to avoid small TLS records
Message-ID: <aqhaJQt7n3fx8CDq@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260909120033.1303511-1-berrange@redhat.com>
 <aqgTBpC0wcuuzYWa@zhexu-thinkpadt14gen5.rmtcaon.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aqgTBpC0wcuuzYWa@zhexu-thinkpadt14gen5.rmtcaon.csb>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Mon, Sep 14, 2026 at 11:30:14AM -0400, Peter Xu wrote:
> Reviewed-by: Peter Xu <peterx@redhat.com>

Ah, I forgot to say this one still breaks !CONFIG_TLS builds, so as long as
that part will be fixed the R-b stands.

Thanks,

-- 
Peter Xu


