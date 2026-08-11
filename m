Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DC2C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 18:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtrg9-00008p-14; Tue, 11 Aug 2026 14:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wtrfx-00008A-8H
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 14:58:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wtrfv-0007CK-Cl
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 14:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786474689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xc1gkSgolc5utfV7OvVEF2vGqC1L4wiEzOW0wSghSXI=;
 b=BcqqTc+uVWHTCnOw5VsYWVBN9Snd4dSkQQUQdsH642g79whJzEDmSTPwkV7OuyPqOYKRRv
 www40A2OO1CMFWVrhyMBNnao5dD+ZR2XeYjuNYswxmzSgzjwsksX8A6rnQMJVF9K7YNK3h
 f2/H069NDn0uDk90vgVghds2UexRGq0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-mY9POekwPhSngw8P2CobVQ-1; Tue, 11 Aug 2026 14:58:08 -0400
X-MC-Unique: mY9POekwPhSngw8P2CobVQ-1
X-Mimecast-MFC-AGG-ID: mY9POekwPhSngw8P2CobVQ_1786474687
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f81362fb1so44592f8f.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 11:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786474687; x=1787079487; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Xc1gkSgolc5utfV7OvVEF2vGqC1L4wiEzOW0wSghSXI=;
 b=DV3ZJrKeovzEmDaH9t7LJ+sMXAcElIGC5PCK4MvtEXiPFH81Xp1sf7KeqDEbjvb/Fd
 HyIj6FfgxgmA9aURBtKWCNw1CQWNzJi38VFtEVvhOJG4IWxmp9YwoViOtoTuEYLNVejH
 CktOZxU4HcV7G5X7I0ZBJLClUGiUUfXxqxfi7bFnWzrFae3wxhQTkG/AfJjckZY2gXoD
 5O9Ho1AX79xIFYy5kDavqH8wuVFrU6AxLX+cMjfiKAXMv4VqTQZJff1meSFiizj0o2Vy
 MGyW317TbO6yrzNUzuqtKF9x4w0PlVFZEVkV7BYzaYrn44RfWNc7fcBiF6E0m0hgfQjQ
 g19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786474687; x=1787079487;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xc1gkSgolc5utfV7OvVEF2vGqC1L4wiEzOW0wSghSXI=;
 b=GzowzVbO/WcdT+Yn3pm+li8Wi606l4JTfsFex1cFCp6rrDxsYaSx809FMpaGufvowF
 su32HM6ptl3GKCy4uLO6MeNS0hKTsr/7NESoW+jws0j6JasW9qc0dqcye4TXP28sqppB
 zvMFlxu1b7tQso/kSmkd93NO12BdBaZQJ+4ktsQpvynpjfNmGCekDtFs+ZzayvY7Dwj+
 XJ890A7QUdhG9HjeJ4PDwBNeZmvmCj5aB3OdOnFDCiYxEo1bt00BzZhmEMldjBeOR4MQ
 9oIWPnTKymH4z+eexnalafS9GSY1oibyzby02Wd1AsEi/dUqxoWzx2T7hSmgJqy/goW1
 4lag==
X-Forwarded-Encrypted: i=1;
 AHgh+RoDzFY6S/+V1RQoSHliqI7uHJxUShayFiWrQ8eS74uWUuE/warQ1BbgiFAeMxX6moOIf7qL3oK2XQSG@nongnu.org
X-Gm-Message-State: AOJu0YyA3AE+onuUMPjCvV7D4WdsPqcRmuUVhFITpkB3wmdm2ZzPKMv2
 w1/uMMPPdR6jLlMo37X/f8UN/uk195nJ4CJg28HBoPDKv3NXUmdVBTXKaZvOLGNUE7WWYUnjCVp
 YnBbU+cvMGmmleI1HOkd0UvUNmKDRi50U2oe2sDuaQ0tgn615YWyMTVlL
X-Gm-Gg: AR+sD11dOFMxhkzho/g5Q6SsiE4edOJb6iBsLgRYWC6FnTOv1sjukNcXeYJPdqspeMs
 EvhJF5J+865oEf1WOrALmhWJMx7aSm46j+U1bfuHSZaY02O/wO0Y622NTWbH7EA2KAUL31jyouW
 pSk+tbmiLs9Ibki30fhYKJHQzcufaIQjbjxGvDBXYmtPUM5Z/XeyDV1Gu4dNBbsIOHpF0NAuxUh
 c5Tj9pSlDXG6hRV8I8d8XiWtUs+grmNT17UNVjvASIFjWqOgJtlNDsi0F9zV/dkDHzojLBnkx5I
 TSccunVpFa4QxeYkpAQgG3b7SAh79NlUtuBxcgoxHUqxbXuPum9bYl4L6YXHZlNPJx6peLoOwn2
 LgNEGPrwZi5mPK9hZiHDFLQ==
X-Received: by 2002:a05:6000:46ce:b0:47f:7786:b00d with SMTP id
 ffacd0b85a97d-4814addc2a0mr6494925f8f.24.1786474686798; 
 Tue, 11 Aug 2026 11:58:06 -0700 (PDT)
X-Received: by 2002:a05:6000:46ce:b0:47f:7786:b00d with SMTP id
 ffacd0b85a97d-4814addc2a0mr6494886f8f.24.1786474686284; 
 Tue, 11 Aug 2026 11:58:06 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-39-98.inter.net.il. [80.230.39.98])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150bf5c5fsm525184f8f.3.2026.08.11.11.58.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 11:58:05 -0700 (PDT)
Date: Tue, 11 Aug 2026 14:58:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <bonzini@gnu.org>
Subject: Re: GCC, Conservancy and Rust AI documents (was Re: [PATCH v2]
 docs/devel: relax policy on AI-generated contributions)
Message-ID: <20260811145706-mutt-send-email-mst@kernel.org>
References: <20260529094619.1034458-1-pbonzini@redhat.com>
 <20260802154350-mutt-send-email-mst@kernel.org>
 <CAFEAcA-VB7kNn6MM4cF7Pz356KgkyKRaK0xMC2PTXYYCVVfLyg@mail.gmail.com>
 <anXuqbBXERqn4lPu@redhat.com>
 <be6325a1-8a4f-4ecf-8045-a56ec66dcd42@redhat.com>
 <CAFEAcA860fF_+ffk=cXiYyFoQo0wCSUJ6b=7nVLLCwKhP6Nwxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA860fF_+ffk=cXiYyFoQo0wCSUJ6b=7nVLLCwKhP6Nwxw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
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

On Mon, Aug 10, 2026 at 11:18:44AM +0100, Peter Maydell wrote:
> On Fri, 7 Aug 2026 at 19:43, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > No one is going to agree 100% with everyone else; the only possible
> > equilibrium is going to be the current "no AI for code generation"
> > policy.
> 
> Also, I'm not sure we even have consensus on what the goals
> of an AI policy should be. At least, in my own mind I am
> not sure about that. We might care about, to different degrees:
> 
>  - the possibility that AI contributions might later be found
>    to be copyright-infringing or otherwise legally encumbered,
>    and need to be removed again
>  - poor quality of resulting generated code
>  - that a large number of individually OK-looking changes might
>    pile up to result in design messes and degeneration of the
>    codebase into "big ball of mud" architecture (you can argue
>    we already have this difficulty without AI :-))
>  - that our already very limited code-review ability gets
>    overwhelmed if we allow AI-generated patchsets (there are
>    already human-generated patchsets which go unreviewed and
>    ignored as it is)
>  - that we don't think one-shot AI-generated changes are likely
>    to be a pathway by which new contributors join the community
>    in the longer term
>  - various non-technical aspects like those the Rust policy drafters
>    labelled as "out of scope for discussion" under the "ethics"
>    label
> 
> (and probably others that I have forgotten).


Well the 15 line limit helps with these too, to a degree.


> The current policy being "no AI" on a fairly narrow legal ground
> had the advantage for me that I didn't need to consider my views
> on all the rest of this. If we relax that strong position then
> what kinds of relaxation we're OK with depends on what goals
> we are trying to achieve and what problems we're trying to
> defend against.
> 
> > Second, the Rust project came up with a different way to approach the
> > issue: require disclosure of LLM-assisted changes and hold them to a
> > higher bar.
> 
> That's not really the way the Rust policy came over to me. I
> read it more as "no AI for codegen, but with an 'experimental'
> back door for limited use". But that comes down to how much
> "experimental" really means that to them and how much it's
> "not actually experimental but the label made it easier to get
> the policy agreed"...
> 
> I do think the "pre-agreement and pre-finding-a-reviewer" parts
> are worth thinking about; to the extent that we've allowed some
> AI-assisted work already, it's had that kind of "pre-agreement
> and done by somebody we already trust as a contributor" aspect.
> 
> Also, I would be more in favour of uses of AI in the project
> that made my life / job easier. "More and larger and more
> frequent patch submissions that I have to review" isn't that,
> so I am not super enthusiastic about permitting LLM assisted
> contributions. ("Deluge of not very interesting autogenerated
> bug reports" isn't great either, for that matter.)
> 
> -- PMM


