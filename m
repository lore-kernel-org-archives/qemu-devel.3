Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97306C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 22:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se0NW-0003pt-GO; Tue, 13 Aug 2024 18:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1se0NU-0003oJ-Ho; Tue, 13 Aug 2024 18:52:32 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1se0NS-0001iI-Pc; Tue, 13 Aug 2024 18:52:32 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D8DE4618DC;
 Tue, 13 Aug 2024 22:52:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACF2C4AF0C;
 Tue, 13 Aug 2024 22:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723589548;
 bh=taGYQNtBhkBLngecX3rD0z1lOHvXGOPIG4tljyveswA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=pM341nC8YVpHBt9jcYyq/lQ9kMmRvfSnJyukeluBc1PzhJ6jHSjgwHyFam3jLsFtJ
 4raLd4dAlLq5ZVTGSI6z4Ocput8BmlH524Br9UzKH+FFIWQ2UD1t0guGzsWH1G177j
 JqkK0X1ZK1ntfCYLNsByHqW97/YgF589IDTWsMhrK539XIT2C+5raJb8C99bc+tRa7
 vFSROiZ3Yw3y47lCQwyqOM8593uYLizA8NpiO0q/2koc10z1j0+mQtVKYtv2yEV3bp
 Ogiecxf3fpE4CrOk8jSXF8PzA8km5dI06vZQOMkicB+zBEUFbWdi6m1qS3fi59twH+
 AUM3Jl8oU8dug==
Date: Wed, 14 Aug 2024 00:52:22 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 04/10] qapi/ghes-cper: add an interface to do generic
 CPER error injection
Message-ID: <20240814005222.74f45f78@foz.lan>
In-Reply-To: <20240812135744.644deaa9@imammedo.users.ipa.redhat.com>
References: <cover.1723119423.git.mchehab+huawei@kernel.org>
 <87799362699e4349ce4a44f3d25698d5764735c6.1723119423.git.mchehab+huawei@kernel.org>
 <20240812135744.644deaa9@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Em Mon, 12 Aug 2024 13:57:44 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> n Platform Error Record - CPER - as defined at the UEFI
> > +# specification.  See
> > +# https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#record-header
> > +# for more details.
> > +#
> > +# @notification-type: pre-assigned GUID string indicating the record
> > +#   association with an error event notification type, as defined
> > +#   at https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#record-header
> > +#
> > +# @raw-data: Contains a base64 encoded string with the payload of
> > +#   the CPER.
> > +#
> > +# Since: 9.2
> > +##
> > +{ 'struct': 'CommonPlatformErrorRecord',
> > +  'data': {
> > +      'notification-type': 'str',  
> 
> like was mentioned at v5 review,
> you only need this for setting cper notification type if you are (re)using
> 
>   acpi_ghes_generic_error_status() && acpi_ghes_generic_error_data()
> 
> however while doing this in (6/10), you are also limiting what
> could be encoded in headers to some hardcoded values.
> 
> Given QEMU doesn't need to know anything about notification type,
> modulo putting it data block header, it would be beneficial
> to drop 'notification type' from QAPI interface, and include
> error status block and error data headers in raw-data.
> 
> This way it should be possible to change headers within python script
> without affecting QEMU and QAPI interface. On top of that
> ghes_record_cper_errors() could be simplified by dropping (in 6/10)
>    acpi_ghes_generic_error_status() && acpi_ghes_generic_error_data()
> and just copying raw-data as is directly into error buffer (assuming
> script put needed headers cper data).
> 
> From fusing pov it's also beneficial to try generate junk error status
> block headers, for which python script looks like ideal place to put
> it in.

Got it. Will change it to just:

{ 'command': 'ghes-cper',
  'data': {
    'cper': 'str'
  },
  'features': [ 'unstable' ]
}

where cper contains an base64-encoded string with the entire raw data
including generic error status end generic error data.

I'm moving the current defaults to the python script. Let's merge
this with the defaults there. The script can later be modified to
allow changing such defaults.

Thanks,
Mauro

