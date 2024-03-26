Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420E1C54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 15:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp9Cx-0003DX-Fc; Tue, 26 Mar 2024 11:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rp9Cv-0003Cy-3u
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 11:59:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rp9Ct-0004a4-Ge
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 11:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711468761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d15WhNfc/b5KrYAViRJoQXka4p4afLDCZN5PnNE3AtA=;
 b=R2W4cVcS49rAvBRWH5EnzTycWkdky5I+MCkah1JfFPQ8LalY0Uqf17icq+3QgP/+B6gkzk
 3WdI3DWai8FCRaVIBQ3zxdwRaZ2AcZuTCEXLBLXnueizbOT2De3vK/5tXR/1S08C6Cao5u
 FVHyt/FMndoioeI/knS/iHTZ5fsQg+Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-A2FZS4dQNDOnJF4WMR_IDg-1; Tue, 26 Mar 2024 11:59:19 -0400
X-MC-Unique: A2FZS4dQNDOnJF4WMR_IDg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDFAE10189B8;
 Tue, 26 Mar 2024 15:59:18 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 99368111E406;
 Tue, 26 Mar 2024 15:59:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 632BC1801492; Tue, 26 Mar 2024 16:59:13 +0100 (CET)
Date: Tue, 26 Mar 2024 16:59:13 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] edk2: get version + date from git submodule
Message-ID: <z5cuq7sx2islbjm6vpu5ksr4b7vytbe5fhhllp46gm5mmqcky4@npmeowuookgn>
References: <20240325144440.1069662-1-kraxel@redhat.com>
 <CAFEAcA9PkAyqVcKMLQZw71FMh6YTpNDNwuKoO0u7i_mRxsJizQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9PkAyqVcKMLQZw71FMh6YTpNDNwuKoO0u7i_mRxsJizQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Mar 25, 2024 at 02:55:11PM +0000, Peter Maydell wrote:
> On Mon, 25 Mar 2024 at 14:45, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > Turned out hard-coding version and date in the Makefile wasn't a bright
> > idea.  Updating it on edk2 updates is easily forgotten.  Fetch the info
> > from git instead.
> >
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  roms/Makefile | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/roms/Makefile b/roms/Makefile
> > index edc234a0e886..534eba17ebd0 100644
> > --- a/roms/Makefile
> > +++ b/roms/Makefile
> > @@ -51,6 +51,8 @@ SEABIOS_EXTRAVERSION="-prebuilt.qemu.org"
> >  # efi ia32, efi x64) into a single rom binary.
> >  #
> >  EDK2_EFIROM = edk2/BaseTools/Source/C/bin/EfiRom
> > +EDK2_STABLE = $(shell cd edk2; git describe --tags --match 'edk2-stable*')
> > +EDK2_DATE = $(shell cd edk2; git show --pretty='format:%cd' --date='format:%m/%d/%Y'| head -1)
> 
> I don't think there's any guarantee that the user has 'git'
> installed. scripts/qemu-version avoids using "git describe"
> unless it's building in a git tree.

Hmm.  Have to figure something else then I guess.

> You can avoid the "| head -1" by using
>   git log -1 --pretty='format:%cd' --date='format:%m/%d/%Y'
> I think.

Works.  Thanks.

> Also, does EDK2 really want month/day/year? Typically silly
> choice if so :-)

Yes.

It's the smbios spec being silly btw, this lands more or less
directly in /sys/class/dmi/id/bios_date.  edk2 itself doesn't
care.

take care,
  Gerd


