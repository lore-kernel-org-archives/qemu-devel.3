Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0860DC624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 15:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x29lD-0008SS-D9; Thu, 03 Sep 2026 11:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x29lA-0008SI-1f
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 11:53:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x29l8-00066R-9R
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 11:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788450829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=64O14QvlKYY21ie3+Vkw2ShSAJTWSPmpeu8FrWkV094=;
 b=OerQKzY8ueSkof7dkIxbyA41S/oO6cE2Lagnqocbuc3OqZlYVkEKCdA643plm5vude+2Dp
 ruUyBipyci6/5tomdVXy8r53CEa4g0DeCQx0UwZOTUH8EyJxWAt1E5PuiEcLqvI5cxrJdW
 teGLg3+UoxG/b7F61q5RWRJa4z+NdzU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-Ayz0u-POPXyRbLMKwvKsLw-1; Thu, 03 Sep 2026 11:53:47 -0400
X-MC-Unique: Ayz0u-POPXyRbLMKwvKsLw-1
X-Mimecast-MFC-AGG-ID: Ayz0u-POPXyRbLMKwvKsLw_1788450826
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49cc954a3edso52965e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 08:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788450826; x=1789055626; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=64O14QvlKYY21ie3+Vkw2ShSAJTWSPmpeu8FrWkV094=;
 b=VzoxeumuyWN3ytv94C9ZcxoVtT/93dGFfjUU71/zaICNQIzFNR7uCP/Hu0ShHMfD67
 5thwHKfMTVkSQYlRPr46d41rx8gIK4057DjxulB4t/oI5HdOAwNMpuBpz2/0yg0ityTY
 j3gtFUwj5pxgkbLrvJyCa5iKoh9PPXuSHW9/LobryuC9SV91XXKGu7yZqk/eiuImP/S/
 JiLI89+cd0XjX1Zr9vvk3IpPug35YUNvy9NpD7xpsi2K6E/fYp3WmVCuUWibHHkMBMT8
 1LZ0do71XEKCW0qc849AxNpif/1iBH4uiuaRU8AEEHwImDhn60I833QF5t78ULErtcIC
 IHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788450826; x=1789055626;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=64O14QvlKYY21ie3+Vkw2ShSAJTWSPmpeu8FrWkV094=;
 b=RnayYDfSKursOoaHpCNw1v+9rLnumFwK3MYc4pRQ1F8iJGeIiU4y/X5Ca6qiBxb6Xv
 dxMWD7oP+f4P4lu3bSGKxQwfLJbmgdQud6QhhfYcQ18gFkXtublG3l8mRfvF12aD6q3Y
 nuu9D5pXWErXHEHUSCnJXgcyZmOLe61q9h6yyK6K0oTuMsIvNXSZj1P1dCkA8oggdon/
 gGM5x7P2Fc9LNdltOdRzmAnHQu7rpOQaOqjSwkgp4i2acX9e+W3IJrXviNw8EG8mNejt
 pLv7WiJs6H4MrpN3BBE5SXZiwv7hU+xNVOCW3Wh25Fhv/6n0V8vWIt4E8Zjay/fRdBqs
 WXDg==
X-Gm-Message-State: AFuF++n+2JwWxHG3yspOfCpjeKilEYR6pn4eF/pWy2fO+rtp6s3dR5JJ
 EqN9KqD6/461T9Zy2Jut419cWHs8fkTQhG4T2sEvEsfhNatBmVsxIyf+qE0/gpxdOwE+RaEhKTs
 ywjplMRqflCjhPEBcxbUvsl7F403iqQrrZzsR4FMya7IK6q1GwAlcYuVc
X-Gm-Gg: AYBFou1Gvq5EX6PUupq+WU4ouROMU/HXK/9Y7uT/pDDgC4xtx+16HtSaRDKCEyQHJPt
 Qis7av3zgukRirc0myr+2ShfQK7drM5ctLRMCF12ZbzECtEum+44IeYI7G2E3GAlSCej6/qA6rR
 ou1VHS4jsH9+3g8kqY8t86iliyfDb0YSaTTxuhdAFQ8f7WnDpInkKY/CCVvFomHV1FV3XqA1RcP
 T47dtdcXLOe6woDfxkj+f0cld3uHUiYcWqLBpqFZYBN2K2fYkB0aAsTuJVLeLX8OpvEdxWwgvxD
 q1C5kio/bh5v0RQLJAwZ0EH62pfoZAcFDLsWNHpIWdu53TuBzCAuWlBflpHR4PWHOkwY23cknqv
 ujen0mFNbgicuAVNV4DTobE8fVvrxnKM7Bi24Cs5WqYWaeA==
X-Received: by 2002:a05:600c:1907:b0:49c:ee08:6ed1 with SMTP id
 5b1f17b1804b1-49cee1d993emr133709275e9.5.1788450826278; 
 Thu, 03 Sep 2026 08:53:46 -0700 (PDT)
X-Received: by 2002:a05:600c:1907:b0:49c:ee08:6ed1 with SMTP id
 5b1f17b1804b1-49cee1d993emr133708455e9.5.1788450825824; 
 Thu, 03 Sep 2026 08:53:45 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5d587csm87064205e9.4.2026.09.03.08.53.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 08:53:45 -0700 (PDT)
Date: Thu, 3 Sep 2026 17:53:37 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org
Subject: Re: [PATCH 2/4] igvm: move set_id_block call into the SNP ID block
 directive handler
Message-ID: <apmSUY-7DTUA1tzu@sgarzare-redhat>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
 <20260901-fix_igvm_policy-v1-2-e93a6cf8c5ac@redhat.com>
 <aplM8ZVCrsjuELHT@sgarzare-redhat>
 <aplyuTrLtvtrT0Kb@leonardi-redhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aplyuTrLtvtrT0Kb@leonardi-redhat>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
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

On Thu, Sep 03, 2026 at 03:29:35PM +0200, Luigi Leonardi wrote:
>On Thu, Sep 03, 2026 at 02:57:44PM +0200, Stefano Garzarella wrote:
>>On Tue, Sep 01, 2026 at 12:09:19PM +0200, Luigi Leonardi wrote:
>>>set_id_block only makes sense when the IGVM file contains an
>>>IGVM_VHT_SNP_ID_BLOCK directive. Move the call from the removed
>>>qigvm_handle_policy into qigvm_directive_snp_id_block, where the ID
>>>block and ID auth are populated. This avoids a no-op call to
>>>set_id_block when no ID block is present.
>>>
>>>The ID block embeds the guest policy, so the policy must be known by the
>>>time the directive is handled. Process the initialization section (which
>>>carries the GUEST_POLICY header) before the directive section, and
>>>copy ctx->sev_policy into the ID block in the directive handler.
>>>
>>>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>>>---
>>>backends/igvm.c | 81 +++++++++++++++++++++++++++------------------------------
>>>1 file changed, 38 insertions(+), 43 deletions(-)
>>>
>>>diff --git a/backends/igvm.c b/backends/igvm.c
>>>index 85de0d54ec..6545382546 100644
>>>--- a/backends/igvm.c
>>>+++ b/backends/igvm.c
>>>@@ -778,6 +778,8 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
>>>   ctx->id_block->version = IGVM_SEV_ID_BLOCK_VERSION;
>>>   memcpy(ctx->id_block->ld, igvm_id->ld, sizeof(ctx->id_block->ld));
>>>
>>>+    ctx->id_block->policy = ctx->sev_policy;
>>
>>Is it fine to copy the sev_policy in the id_block in any case?
>>
>>I mean, what happen if IGVM_VHT_GUEST_POLICY is not in the IGVM 
>>file, so IIUC sev_policy is 0, but the user set the policy by the 
>>CLI?
>>
>>Maybe this was pre-existing and handled in the next patches.
>
>This is a very good question: id block per snp spec *requires* a policy
>to be set. So can we consider an IGVM file that contains a id block directive
>but not guest policy to be valid? If so, I need to modify the code and read
>the policy from `kvm_start_conf` with a new callback.

Yes, maybe we could throw an error in this case; otherwise, the only 
other option I see is to use the same default we use for the CLI, and at 
this point, reading `kvm_start_conf` might help you keep the default in 
just one place.

Stefano


