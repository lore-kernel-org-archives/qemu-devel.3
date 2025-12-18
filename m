Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FFFD711C4
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 21:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWLrC-0003Dg-VX; Thu, 18 Dec 2025 16:48:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vWLr3-0003Bu-4Z
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 16:48:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vWLr1-0005rx-NP
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 16:48:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766094490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SLvCkQ55SOB6YgWhNdfV5D9i6FWmMusnSTo3fV09B48=;
 b=Gt1NCEO4JjlJOYlo6DShnfSE2nDO22xNwuiGdnwkF4kGTncs+BS+b9N0NSvnNzxIq2pz2X
 pGuosHu1t0IOPNG2nFraFfxq8kYbGhWw6zenAQNzXppHRgy0Z6EaiN9n0HoqFjzhiOXaoE
 A7+zMo9+Q8m60BtXunVtU8Nj/4Lrxy8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-mLYy2R1cPsSUqwsKOJn-Nw-1; Thu, 18 Dec 2025 16:48:09 -0500
X-MC-Unique: mLYy2R1cPsSUqwsKOJn-Nw-1
X-Mimecast-MFC-AGG-ID: mLYy2R1cPsSUqwsKOJn-Nw_1766094489
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8bb3a245d0cso229037585a.2
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 13:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766094488; x=1766699288; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SLvCkQ55SOB6YgWhNdfV5D9i6FWmMusnSTo3fV09B48=;
 b=m3lc+EZiCKh5Vgg7gBLQWtqhim1l1LTppMdCat2+l9xLzvic1zFqkDk4HIsS9Wb/Jb
 OO22KLgluybawvPzbrDpqNUsuujD4uOUWl+HP6LWf6PyZe1Qy82tG+mjFBvTqY/u8ifl
 bQvo0Fd29AKtqvVXSiU9+wssqPWR5Ud5Pmglh30gBgx/fCEIdj7iMcrSM/qcsWR9O4Pv
 iGyAVLPnWn587WnxxFjVhK71v+FpLAxZY24jd9v7LnANYBbLrlb8/A35dTnWr1nubGeV
 dhElQOUBFJ7/T0iJXV8hND4dnUMqBKFsWk/lRzjXP8eMixt3+E3+84rPNLTZb0VV17N2
 UWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766094488; x=1766699288;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SLvCkQ55SOB6YgWhNdfV5D9i6FWmMusnSTo3fV09B48=;
 b=i4ggafGsFpcLP9eIwbzfpknpBi6hX0wkSRJP5w11VXtIoQJ2gj1NmU1CI38QAHiDG9
 MuaUydp8v2y8Nmk0TN2ieOvAdgqu1wLBXKSLen0WQvwgH2/A1mJdMiDMOxl2C7PkiVXd
 Aj8o0JYboFZt+wrjQ5wH6XnH6b1zqTUhJkjf7MVAR3XXWTSlpLgL99ECgykgPrb+NazL
 MjRv9kjk+3n2us/VEt+3pcAZ3MpxRMTrNzg4GlVyhbvqDRGSz2+lxcWqcJVG8dhSXZG1
 8kFkoDGUN1v2lA2bhkxSoWDrZwE9RXcpBsVaO+m+KgPyJxcJ4H17IqgK2AXlu4mkxg/X
 /R4Q==
X-Gm-Message-State: AOJu0YxtzLRV2+58HLVRaWr4GOvRKQvZwOx0os9PaBdlvFVQhrkl/c1Z
 n5f5HdfWRtEEuer3MOlGcYLiW2XlM2xeQ2kIEYA89MsWoudbj8048FUOOwbJwek5i4vGJZkGHdS
 FAwYSRh6Ja6Q4/ILfi4ZSoA5O8ZIOlcNjLGiqNLjGpoUP6tV5DXxc31P7
X-Gm-Gg: AY/fxX6ybbobLSdrmo7JmX+D1mJl5NZ2+RwM+kZFBNjcpl9gIA7iTehKDDBU+BhMgr4
 iopoCpa424BI+zcPu4lquFCJw4irdHoYTxyax02mGM2VnPRBNaC4T0G5NNyls2mAsLUew7x1Hel
 0EDj8/RI/KQ3MF4K4LAAnFqGQqOAJjkBe59Ee5in/+kK79N1wDF99kcwhM/vxgvUi+dgqiqKXZY
 TeGEVay+0F+dl97RAdwIaJnkN4KZ3OAI/x9pev21+uaPAfPnNEzVl2AeZw6TyBRr/7Hl5sEcqGK
 zQAxmRNPvrle6/HLjrZ1IWCOZ06+QQnj2khqjl0JBBrmrwD69TEMoZp+zNTArWDZPUK4ManSuWl
 kEZA=
X-Received: by 2002:a05:620a:172b:b0:8b2:e3c1:24c3 with SMTP id
 af79cd13be357-8c08fac0b9emr189866385a.64.1766094488541; 
 Thu, 18 Dec 2025 13:48:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdWLzV+IhCXOfk/IVYQ4gZuvnCMMUjIoy8K367R1tqv9eC/N0whw8iBu/33wVIa3XyknmeHg==
X-Received: by 2002:a05:620a:172b:b0:8b2:e3c1:24c3 with SMTP id
 af79cd13be357-8c08fac0b9emr189862485a.64.1766094488086; 
 Thu, 18 Dec 2025 13:48:08 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c0970f5fcdsm34597185a.29.2025.12.18.13.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 13:48:07 -0800 (PST)
Date: Thu, 18 Dec 2025 16:48:06 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 41/51] tests/qtest/migration: TLS PSK: Add
 init/cleanup routines
Message-ID: <aUR2ls7JH_r9uQNG@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-42-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251215220041.12657-42-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Dec 15, 2025 at 07:00:27PM -0300, Fabiano Rosas wrote:
> Move TLS PSK setup and cleanup into a common function instead of using
> hooks. Hooks are for when the test needs to access the QTestState.
> 
> This primarily moves setup of TLS PSK tests from ->start_hook time
> earlier into test function call time, which brings the migrate_set_*
> calls within earlier, where they can be replaced in subsequent patches
> with the new config setup.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration/tls-tests.c | 149 +++++++++++++++++-------------
>  1 file changed, 83 insertions(+), 66 deletions(-)
> 
> diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
> index 2eeed1fc5b..aade57f7de 100644
> --- a/tests/qtest/migration/tls-tests.c
> +++ b/tests/qtest/migration/tls-tests.c
> @@ -23,12 +23,12 @@
>  #endif /* CONFIG_TASN1 */
>  
>  
> -struct TestMigrateTLSPSKData {
> +typedef struct {
>      char *workdir;
>      char *workdiralt;
>      char *pskfile;
>      char *pskfilealt;
> -};
> +} TestMigrateTLSPSKData;
>  
>  typedef struct {
>      bool mismatch;
> @@ -44,59 +44,62 @@ static TestMigrateTLSPSK tls_psk_mismatch = {
>  
>  static char *tmpfs;
>  
> -static void *
> -migrate_hook_start_tls_psk_common(QTestState *from,
> -                                  QTestState *to,
> -                                  void *opaque)
> +static void *migrate_hook_start_tls_psk_common(QTestState *from,
> +                                               QTestState *to,
> +                                               void *opaque)
>  {
>      TestMigrateTLSPSK *args = opaque;
> -    struct TestMigrateTLSPSKData *data =
> -        g_new0(struct TestMigrateTLSPSKData, 1);
> +    g_autofree char *workdir = g_strdup_printf("%s/tlscredspsk0", tmpfs);
> +    g_autofree char *workdiralt = NULL;
>  
> +    if (args->mismatch) {
> +        workdiralt = g_strdup_printf("%s/tlscredspskalt0", tmpfs);
> +    }

Nit: similar string duplications here, now two (workdir, workdiralt).
I guess OK for now,

Reviewed-by: Peter Xu <peterx@redhat.com>

dedup somehow would be better.

-- 
Peter Xu


