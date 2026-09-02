Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A706C624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 13:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ke9-0001lE-7p; Wed, 02 Sep 2026 09:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x1ke6-0001jV-1V
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 09:04:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x1ke3-0004Bc-Sz
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 09:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788354288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I3TXe2Wa9qZ1vLE2Jo4BXMKCAGSrYDMKmfvSgA2feXc=;
 b=bVRFedwKbTvHs+DR1vLKNr3Gc9W3h5RcqJFGgHbtEhLfc8mb4UXdgcELXmzC6oTgrOJ2FP
 /yOxfnbc75vPi/Tyk+yKZTGaPpJKgkbTFNJR0nByX0Pz9t8awLT+vc2fuqnSAAH1D2bJkp
 Dyws4hEqp3JYDDBxoj8X7s7B1H9G/kU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-7FkyCHnVPligvoo7SeCprg-1; Wed, 02 Sept 2026 09:04:44 -0400
X-MC-Unique: 7FkyCHnVPligvoo7SeCprg-1
X-Mimecast-MFC-AGG-ID: 7FkyCHnVPligvoo7SeCprg_1788354283
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-495569acf8dso6690085e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 06:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788354283; x=1788959083; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=I3TXe2Wa9qZ1vLE2Jo4BXMKCAGSrYDMKmfvSgA2feXc=;
 b=QoceWhvXvM5WfDspfZC0g3YW4f08OZNSPGWqgcHBT8NKW80nW263a3CBxyXxJjwg4w
 C4zpJgaC77aoRw7D81hF+N0n1Zh+VDyVf+h0+OUuGB22GDMISYeHUJaL/IROQfdYNm0K
 fpupz675XbU058jjByQgDWOXdqd8pCGlMiuJ+iO+EX+pUXwjSAyd+R49NwqGSkwJL9+R
 3N1WVnUMEYlFlEsfoRMGVkGqpUka36eienw0ahAhJjrur4tCmYP+y5k8Nsn9DVMfa2dz
 BaERTLtDsfmlulqZySDzz5PWkq5HfABXp9seVBosoBZo0uJ0xLBpYe4PACp6O7FQ6ehQ
 m8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788354283; x=1788959083;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=I3TXe2Wa9qZ1vLE2Jo4BXMKCAGSrYDMKmfvSgA2feXc=;
 b=PwLnSrlko9SIBAxNNnjncoAph8Q0D/jSLx3Jq3CI/OWv1cFxgcSaEpN2TZMa7G2qsR
 GO3UaUaqnT2/YFm9dQfEWRmAMU54yT/1sRjiiPyzLKeVOp4fwwFvnaNgRWbyHCEKMoUY
 z1FmuUcDTmM4Jr5IqaiPwOIbtRQCT6t63iyP3ZC5sdschB19zs3eIKvqsmozasq2rB7i
 47vFxBJ8eEesANFIJIdmWDmWUj48XueLc46YKEatiOVqIVCbsFISOs+LJY0Rsdl+W5kF
 PMn5RRq72IsDJ6Ul//HyOiTpVXpidDP5JU7uYDnCIslw8WjJd2emRdk6oiR+vpuEbzra
 PcJA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrc+tnlRT5cYfGgeXeFQdi1usFeZ9nGqLMlbZKYMRZHO3YFC3dvECYfn8NRESp/0ACP00S0Im/vksJm@nongnu.org
X-Gm-Message-State: AFuF++kbFfeVqPX3LZumgRNMq3jFL19NZrtbCnbBawQEAOlD5wqLSzwz
 N3oww8ZepeidMIscvStalLRwmH6qfuA3fxiYuUYNcj09RGUgnw/Vv1Eqw0VrUP2qLNOKRhRZ4pO
 f0OK5lc1MQknWladWEzUuUPFdX/4SYtXerRctjMZO5dWJDgpv9kItLydE
X-Gm-Gg: AR+sD11X090iwMigtcKgsRN/MnfNm/Rup+vzHdlG6jnC8V6pUesxH0M3DBs0rmdv2iT
 szdnFrlok0RKWY1MjvvQP+3Jg9T7qIqvc5eiLZPGBJ26CitdfWO8xNRilOEi2ri8Wp6Ih7m7OtY
 gxHUu+aVVDyCp514Oj4x9+36L9Cu00aCV0+XIItfWyUVPLIXMTlm2rbXZcxFjhRe41KOkgF8p86
 mPw5Pi8jwb89ELEp8P2VlZLwzd/2u2zqw4LRtEadZiioOEoXevZR27a4dymXcL74XFfDUMLWG8C
 1u3aizC1ToPMicE6AKtD06I0qnQxZx7hzlH+ZF7eX+vNFpKYrXkxL3r5rRK+5DoqhwE=
X-Received: by 2002:a05:600c:3b11:b0:49c:dca4:94c with SMTP id
 5b1f17b1804b1-49ce5843baemr81247015e9.13.1788354283048; 
 Wed, 02 Sep 2026 06:04:43 -0700 (PDT)
X-Received: by 2002:a05:600c:3b11:b0:49c:dca4:94c with SMTP id
 5b1f17b1804b1-49ce5843baemr81245735e9.13.1788354282541; 
 Wed, 02 Sep 2026 06:04:42 -0700 (PDT)
Received: from redhat.com ([187.15.128.103]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e72df2sm6855862f8f.1.2026.09.02.06.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 06:04:40 -0700 (PDT)
Date: Wed, 2 Sep 2026 09:04:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 4/4] agents: add CLAUDE.md and GEMINI.md
Message-ID: <20260902084735-mutt-send-email-mst@kernel.org>
References: <20260901161422.314581-1-pbonzini@redhat.com>
 <20260901161422.314581-5-pbonzini@redhat.com>
 <20260902054543-mutt-send-email-mst@kernel.org>
 <CABgObfacwO0bx+wc2s=5aiaEbQghvt-gZc77D6eDigf88mS1zA@mail.gmail.com>
 <20260902060604-mutt-send-email-mst@kernel.org>
 <apf2gT5GBD6HZosQ@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <apf2gT5GBD6HZosQ@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Wed, Sep 02, 2026 at 11:12:17AM +0100, Daniel P. Berrangé wrote:
> On Wed, Sep 02, 2026 at 06:06:14AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Sep 02, 2026 at 11:56:46AM +0200, Paolo Bonzini wrote:
> > > On Wed, Sep 2, 2026 at 11:46 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, Sep 01, 2026 at 06:14:22PM +0200, Paolo Bonzini wrote:
> > > > > diff --git a/GEMINI.md b/GEMINI.md
> > > > > new file mode 100644
> > > > > index 00000000000..43c994c2d36
> > > > > --- /dev/null
> > > > > +++ b/GEMINI.md
> > > > > @@ -0,0 +1 @@
> > > > > +@AGENTS.md
> > > >
> > > > gemini seems to support agents.md - r u at the latest version?
> > > 
> > > I tested and it doesn't load it for me.
> > 
> > ok then sorry.
> 
> It appears to be doable via a custom setting:
> 
>   https://geminicli.com/docs/cli/gemini-md/#customize-the-context-file-name
> 


oh I see, I have it, that's why.


> IOW, we could add a .gemini/settings.json that points it to AGENTS.MD
> instead of having a top level GEMINI.md file. Both are somewhat
> unpleasant given they're tool specific, but I'd have a slight preference
> towards the .gemini solution as dotfiles are a hidden files in many
> contexts.
> 
> Similarly IIUC it would be possible to have a  .claude/CLAUDE.MD
> file instead of the top level one.

Indeed.

I'd prefer a softlink under .claude/rules personally - i have my own stuff in
an untracked .claude/CLAUDE.md and I feel it's nice to give user
supplied files priority.

> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


