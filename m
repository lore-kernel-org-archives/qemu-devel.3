Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92446C78820
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 10:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srb9H-0007Ia-It; Fri, 20 Sep 2024 06:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1srb9G-0007HO-6z
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 06:46:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1srb9E-0007TL-IC
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 06:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726829158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wazcsTEUx4Ok3WAAMX/+jlRi2pI9Ly5VlS2VLdqlyto=;
 b=Y3gWnmb6YV4xQzteWrm/clciZtqcdKwHKn12MJ6DtOi7zvU+EatBSQRDxIHXJQjyGVTup/
 Xat9GGeQfvDw3Dq/J4vT8xzJlEQ47l5FU2t2g5AIjaD1gxUwS3MuehmGWV9wflM1t9XDC+
 Nlp8AX0Vf6OOtB9KxkqDdIrzWceGOt0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-xfmDksUrNrGZEh3uMvAaDw-1; Fri, 20 Sep 2024 06:45:56 -0400
X-MC-Unique: xfmDksUrNrGZEh3uMvAaDw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-374c301db60so763285f8f.2
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2024 03:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726829155; x=1727433955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wazcsTEUx4Ok3WAAMX/+jlRi2pI9Ly5VlS2VLdqlyto=;
 b=MT5vI31PdwEL4zv+mTEcn9bsZ1q0vehB8FRQQFtEZJkoCXLRbQ+UGVGFXBdz+xIlvi
 fCXNDduSPcWCa7zN+G6bZRGulrS+9c59MRVLkHWvNR5BUeL3S9UFijr/kpLCI6urgmM+
 k9oiVBIl46W/dRwCpyNQWgK6KtjM21XKdvRwZ5zWstAaQyx16gRmidmg9LCTSYEPLVuj
 pJijhw/E4j1AeGr8+NH6z1yBr1I//nwzsVfuSsiA4yW/PqY8mnsixt1lp5HkpOLON9je
 xu1QCJ0Lq0Z9iyTABU22TSIsPAUbIV+DCUd1NBvjpRoOe5hgpJakVTme/w/fOMOctzyg
 GbpQ==
X-Gm-Message-State: AOJu0Yy431fJdzwHnUUaRYXEOQH3xGae7CFJ78vg1+uefAHItVYzyDiv
 bI4ChWL/MEUtj94W9XtuvtH3OvggkEOH3N50obIQCN9qWDv0/PPMwSPWyOmmMp2wqeEr9gscEuY
 yIp6jTmXE9ViurMCvHOr13qFRD15QCFFX6Imsip2YQPo7X2CDksU+
X-Received: by 2002:a5d:5f83:0:b0:374:c977:363 with SMTP id
 ffacd0b85a97d-37a43154e86mr1410053f8f.24.1726829154775; 
 Fri, 20 Sep 2024 03:45:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpVg1RSYovUWrhLSt3AeDyIAq2AKjhtwPZz44IdQ+tJqDV+PRmdSR/5FlFX9i1FVxJ4UeS8g==
X-Received: by 2002:a5d:5f83:0:b0:374:c977:363 with SMTP id
 ffacd0b85a97d-37a43154e86mr1410035f8f.24.1726829154309; 
 Fri, 20 Sep 2024 03:45:54 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e78054c3sm17580176f8f.105.2024.09.20.03.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 03:45:53 -0700 (PDT)
Date: Fri, 20 Sep 2024 12:45:51 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] docs/system/cpu-hotplug: Update example's
 socket-id/core-id
Message-ID: <20240920124551.56f1e832@imammedo.users.ipa.redhat.com>
In-Reply-To: <CAFEAcA94EdUOOk71nv4oFRJXNBM=62FCD9dfwVSWMS-VM_OZtw@mail.gmail.com>
References: <20240819144303.37852-1-peter.maydell@linaro.org>
 <20240910110344.10e4805e@imammedo.users.ipa.redhat.com>
 <CAFEAcA_Rjiy1so28OVPpL=+++XuU+gSXhn-v_WHMcpc_wa_xMw@mail.gmail.com>
 <CAFEAcA94EdUOOk71nv4oFRJXNBM=62FCD9dfwVSWMS-VM_OZtw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 19 Sep 2024 13:34:54 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Tue, 10 Sept 2024 at 10:38, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Tue, 10 Sept 2024 at 10:03, Igor Mammedov <imammedo@redhat.com> wrote:  
> > >
> > > On Mon, 19 Aug 2024 15:43:03 +0100
> > > Peter Maydell <peter.maydell@linaro.org> wrote:  
> > > > @@ -83,34 +83,32 @@ vCPU hotplug
> > > >
> > > >        (QEMU) query-cpus-fast
> > > >        {
> > > > -          "execute": "query-cpus-fast",
> > > >            "arguments": {}
> > > > +          "execute": "query-cpus-fast",
> > > >        }
> > > >        {
> > > >            "return": [
> > > >                {
> > > > -                  "qom-path": "/machine/unattached/device[0]",
> > > > -                  "target": "x86_64",
> > > > -                  "thread-id": 11534,
> > > >                    "cpu-index": 0,
> > > >                    "props": {
> > > > -                      "socket-id": 0,
> > > >                        "core-id": 0,
> > > > +                      "socket-id": 0,
> > > >                        "thread-id": 0
> > > >                    },
> > > > -                  "arch": "x86"
> > > > +                  "qom-path": "/machine/unattached/device[0]",
> > > > +                  "target": "x86_64",
> > > > +                  "thread-id": 28957
> > > >                },
> > > >                {
> > > > -                  "qom-path": "/machine/peripheral/cpu-2",
> > > > -                  "target": "x86_64",
> > > > -                  "thread-id": 12106,
> > > >                    "cpu-index": 1,
> > > >                    "props": {
> > > > -                      "socket-id": 1,
> > > > -                      "core-id": 0,
> > > > +                      "core-id": 1,
> > > > +                      "socket-id": 0,
> > > >                        "thread-id": 0
> > > >                    },
> > > > -                  "arch": "x86"
> > > > +                  "qom-path": "/machine/peripheral/cpu-2",
> > > > +                  "target": "x86_64",
> > > > +                  "thread-id": 29095
> > > >                }  
> > >
> > > beside reordering, which seems fine, this hunk also introduces target change
> > > perhaps a separate patch for that?  
> >
> > What target change? It all says "target": "x86_64" both before
> > and after. 

my mistake,
I should've said  '"arch": "x86"' instead, which is gone after the patch

> 
> Hi Igor, would you mind clarifying what you meant here?
> I'm happy to respin, but I don't understand what change you're
> asking for.
> 
> thanks
> -- PMM
> 


