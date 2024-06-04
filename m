Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F3AC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 09:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQ4w-0003CP-1I; Tue, 04 Jun 2024 05:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sEQ4p-0003Bu-26
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:03:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sEQ4n-0007Gg-1b
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717491807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zTryAwAqFpVVeeFnolgKRJ1jpm4fqSOt2rryPRNNmtg=;
 b=fSq33TwKtZ0PqsttDF0Dw75woOcZtHWONlqGddlquqrtXeokDOY7+MfQCO32q/p4TBpfX9
 itpENZagPi9hDBfyhh+HDFeOTc1SFypstZfHnlW52+NKuln1ppVljIh4yLGxdX6g2gwxzy
 LigN7Y/JmBfjAsValh9oc1QbSRc/HxA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-Zm8srSYdP5mU-GgZ412-5g-1; Tue, 04 Jun 2024 05:03:21 -0400
X-MC-Unique: Zm8srSYdP5mU-GgZ412-5g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1810B101A521;
 Tue,  4 Jun 2024 09:03:21 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD4AB2028B56;
 Tue,  4 Jun 2024 09:03:20 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id ED737180098E; Tue,  4 Jun 2024 11:03:19 +0200 (CEST)
Date: Tue, 4 Jun 2024 11:03:19 +0200
From: "Hoffmann, Gerd" <kraxel@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Pankaj Gupta <pankaj.gupta@amd.com>, qemu-devel@nongnu.org,
 brijesh.singh@amd.com, 
 dovmurik@linux.ibm.com, armbru@redhat.com, michael.roth@amd.com,
 xiaoyao.li@intel.com, 
 thomas.lendacky@amd.com, isaku.yamahata@intel.com, kvm@vger.kernel.org, 
 anisinha@redhat.com, Oliver Steffen <osteffen@redhat.com>
Subject: Re: [PATCH v4 29/31] hw/i386/sev: Allow use of pflash in conjunction
 with -bios
Message-ID: <vcvfiqwhv7v3dhlmolz6ur4a62yfbyusihdzk5w7etyv676xmu@5xdmf7recsjz>
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
 <20240530111643.1091816-30-pankaj.gupta@amd.com>
 <Zl2vP9hohrgaPMTs@redhat.com>
 <CABgObfapGXenv8MZv5wnMkESQMJveZvP-kqUj=EwMszTkg0EsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfapGXenv8MZv5wnMkESQMJveZvP-kqUj=EwMszTkg0EsA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Jun 03, 2024 at 03:38:05PM GMT, Paolo Bonzini wrote:
> On Mon, Jun 3, 2024 at 1:55 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> > I really wish we didn't have to introduce this though - is there really
> > no way to make it possible to use pflash for both CODE & VARS with SNP,
> > as is done with traditional VMs, so we don't diverge in setup, needing
> > yet more changes up the mgmt stack ?
> 
> No, you cannot use pflash for CODE in either SNP or TDX. The hardware
> does not support it.
> 
> One possibility is to only support non-pflash-based variable store.
> This is not yet in QEMU, but it is how both AWS and Google implemented
> UEFI variables and I think Gerd was going to work on it for QEMU.

Yes, working on and off on it.  Progress is slower that I wish it would
be due to getting side tracked into other important edk2 things ...

But, yes, the longer-term plan is that edk2 wouldn't manage the variable
store itself.  It will be either qemu (non-confidential setups), or the
svsm (confidential setups).

Where we are going to store svsm state (vtpm, efi vars, ...) is not
fully clear yet.  pflash is one option, but we are also checking out
alternatives like virtio-blk (via virtio-mmio).

take care,
  Gerd


