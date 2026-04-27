Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC6DFF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHHld-0001Bu-22; Mon, 27 Apr 2026 04:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wHHlV-0001BS-Mm
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:56:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wHHlU-00048a-7C
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777280186;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vb8BkJSh5QdGKAi866gfNw8V0GOij9dwYQOtmdSzxyM=;
 b=DqVixsuL1yVL05FyEfiPSVutXYqcq01fyb5VFJLvd185S+AD6zgsgaRDA0PVSUdxwwwPdG
 LpsqnsXqevpwl/qinS90Ala0U+egI1bwX2X89mFSsXanVJsnvrKOntpTtnM/or6uU9Sqkp
 XjGjoofgmHzEGmpCFEmlHBWhvlpQkDo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-Oa-T-wdHPr-sHSv1BDY9kw-1; Mon, 27 Apr 2026 04:56:25 -0400
X-MC-Unique: Oa-T-wdHPr-sHSv1BDY9kw-1
X-Mimecast-MFC-AGG-ID: Oa-T-wdHPr-sHSv1BDY9kw_1777280184
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-441243ba35fso5087788f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777280184; x=1777884984; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:reply-to:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vb8BkJSh5QdGKAi866gfNw8V0GOij9dwYQOtmdSzxyM=;
 b=IQsF6ecIp0xJ2PCqws8SOT60Jib+qpgr9rOycX7ZRQLSjjKaWVRUdvFiaoBGA48IRU
 QMJ+qvOGc2CNkqxOwF8xxIqkGPdCAllupAms63EcRNfQ4d5GnEyuXzRXOGxBmeOKdTef
 DrbMj7iyrC0eREco83vPg9qAM+W1bZpxVbDlR1E2JmGna7S3bgQLnhahSaUEsWwisNb1
 nlwklipS85Lye7fICU4HqBOcAsmClJd9U0rBkFr7xNFI45q8DWTwXcACYuQ3whONUJc/
 J79A2nW76oZzrEajG5ZbGrxfHut2SB2l5Clfoa8eQR094jgn3E3TqK4bAUxzJjzUNY3A
 yMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777280184; x=1777884984;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:reply-to:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vb8BkJSh5QdGKAi866gfNw8V0GOij9dwYQOtmdSzxyM=;
 b=AD497IDo23va/wG1+IdEJJJs77azBh349vNfMo5a/Z9MrcjghbXxnZxplea+4tkoTE
 rAQ765o60BnIJA0iPsWPZ1ohArbOsUifRfDALBiEhsJcAgEEPe6KNLE6/dFRsED/W5po
 UkiyQ+CMiiod6avQmaIMGTmUU+MPmx/NxFJfpXVhra1tW1yijNJR7ODe8m+WxYBvWEjD
 EE+LzcnZ/Z+M89luOCzE1I+CDGVWErnbqO06c4dGDeYlj2TnE/lnD4aQpep7MxPImKwt
 z9RLUYyEWPn1ej27Sx9vPoCL/6HG++bX2taEPSB15RYfJzAHzvZqQ/MiYUQ5GiApxVrm
 WQYQ==
X-Gm-Message-State: AOJu0Yzjrm7VTIIKPVwG037lsv5Qw++kG+o5dcsT5ja4ooAhGSY4Qf6D
 VilbXrfDgTxBxy9/ztxltNSAJAQkksQzEv3EKb/c83uf2vbLTqscQFD7va2ZjkiOICYnBW9WhDY
 R/NJtLuECgCNv5j+JZ0YXbv21gBU8eoEr1rXycnwbdMU/Ih+rsyp+dQoU
X-Gm-Gg: AeBDieuNV0Mq1GJq+v5OLS7KOB2mXTaBdPHOy4l7UylzZdwjnfK8u0+e5jpbZepJ0iu
 g9Tz4FhNp3Hcg5Ry/8nm5DC0IVHyj5fdHuh7Ru4S1w3D580jrrOjIRIufyzJwfyi3JI0LSl68YT
 Ag+dy4BQg4ubpIlbhiULcx29YMjR32s3pnVM9VnNsXLnDh/d2yzfm4aJzJ8qXtuD+Hb18Esn9N4
 3WbTVQ+QixRVlfmVssU0XW/e4gtR0JwMgd82npJBOTJQVV1Z9nWLu2xRJDwlxccYIa3V8WbqUEY
 BoaiU93z8PlGLoQaim7vodd/SmB2Yh+Np5n+hENSq021HIpD3iMgrB1vPOwNe66HqpQcbU29Ow5
 zCVew+m7BOVIOm+FHFG66p0ezc69jNBo=
X-Received: by 2002:a05:600c:4e8f:b0:489:1fa5:997f with SMTP id
 5b1f17b1804b1-4891fa59adfmr444087435e9.9.1777280183604; 
 Mon, 27 Apr 2026 01:56:23 -0700 (PDT)
X-Received: by 2002:a05:600c:4e8f:b0:489:1fa5:997f with SMTP id
 5b1f17b1804b1-4891fa59adfmr444086995e9.9.1777280183056; 
 Mon, 27 Apr 2026 01:56:23 -0700 (PDT)
Received: from redhat.com ([2a02:8012:f011:0:f1ce:ac56:d2cd:7c2e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc10777csm880143655e9.8.2026.04.27.01.56.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 01:56:22 -0700 (PDT)
Date: Mon, 27 Apr 2026 09:56:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Jind=C5=99ich_Makovi=C4=8Dka?= <makovick@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/2] Fix and re-enable GTK clipboard
Message-ID: <ae8ktG9zNOKXHgSu@redhat.com>
References: <20260426-gtk-clipboard-v3-0-09555aaeda34@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260426-gtk-clipboard-v3-0-09555aaeda34@gmail.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Apr 26, 2026 at 09:52:32AM +0200, Jindřich Makovička wrote:
> The following patches change blocking clipboard retrieval function
> calls in gtk-clipboard.c to non-blocking variants using callbacks to
> avoid UI lockup. It is a follow-up to the patch proposed in the GitLab
> issue
> 
> https://gitlab.com/qemu-project/qemu/-/work_items/1150
> 
> This version adds a similar change to gd_clipboard_request that also
> uses the blocking clipboard API.
> 
> The second patch removes the gtk-clipboard flag, keeping the GTK
> clipboard always enabled.

I notice that the current code in git does not provide any command line
option to turn on/off the GTK clipboard sync.  Considering that VMs are
often used for untrusted workloads, or workloads that are less trusted
then the host OS, I would consider this GTK impl to be a security flaw
in QEMU if re-enabled as-is.

IMHO, before we remove the ifdefs in the code, the "DisplayGTK"  struct
needs to gain settings to control the clipboard synchronization, and it
should default to disabled.


