Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB59CD8C9D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXXkU-0004fA-9X; Thu, 11 Jun 2026 01:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXXkH-0004co-D1
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:14:26 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXXkE-0000np-Nj
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:14:25 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-490b8a97b11so83661665e9.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:14:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781154859; cv=none;
 d=google.com; s=arc-20240605;
 b=lTrXZ3ye0XDsdSPkukN+1nSYUSHPrXDUPbj6c//zMenclXUqLnwbW9KCJKVxmwVw37
 r1eR4HYXKCxiC0Tstbwz8r2A896mpXIalJhHA+sRbeZ5Hn1C030ik8iAx1jM9n3zh7P2
 hm2JXz1eYj9IgmfQ+cMgAA+qm3T+iOd2fQT3pZuGBpFEI0WOp4RSBrgkgWMC1NipIL0M
 SVShQooseMwFaHNYcUe8HrL9BrEn7BpCtq/Dp8k/spSDQaDTuEhGqnj52zarvwwFmS7o
 mvQQ1X+N8+TTv9z5DK0C0lkJAv2ZrTW1gjtVfCgzhN/7XHdnTm4ElqmHjhIVOA6WDD8/
 WfBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vu/KYm0KtD2vkEd5L0JojkkS2QIaDn1D1f6ZazfHu0w=;
 fh=YBFN6sLm21gmJxCSu10/1CqbRgX6DuaJxwQ6OELLRx4=;
 b=f4+sVzQ7EHHfqppOQpnxXOzBWPKHGF0lZoXu3Bwn1CE5gplypldU4lTxTkNxOiOoT+
 FZi50Hb3Sp+ul9zJ6UL2TL/f7Bemm2FeQE5LKXzLLOGN3VsMUDVr9lHn9Fsuhsn+i88B
 a+u7Y+te8uPzUMF01ZcTdQHkKxmCamp5XdcwwKbeNAgAYDLDXx4j6ApqRB6509UTBkw+
 X555ckPWddhchMxn5GxwxVPLMFuXU8PAItKRVAFLSZHlJZ5vEXsAKatmWv+ZGPFAMl9M
 2U42OmrW+LnX7ec3YMPqVkqG9xL40j/wraeoZQcFNhfUn5T9WQJd2dxWQXDhhLw0PXxp
 Sdjw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781154859; x=1781759659; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vu/KYm0KtD2vkEd5L0JojkkS2QIaDn1D1f6ZazfHu0w=;
 b=t7OBSGOU/WfPP/PiGZYLAJNDx5ZgK0+flgfO/oy/qynfgg2Z4PSzsPf4s4odhvSB7D
 OHfyE4oaI9ui+rxmnOt4ZyaZgMsN86VakDck9bDiJWbTSPFtXiWHD8IuOIGiVsLKwAp6
 eWuLjmTO3sGIfDkKyX9smkPuItPN6PFFMbNMk8JZR/4j3cFzHtzMf9XEV7h2YXHhqG1Q
 bt7ZDlgVkJO4+HTXj3Tas3bkMzgscfIb7ACjdAU0XaoldVkEcDVfCsN0e6MH6vsC8c2W
 GDJ2MrD/31I3Uo4LeA9A2yNCbHfbd6bATMseecdLyscKNg/IkKvmDRkLEjo/3EnvK7Ew
 19Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781154859; x=1781759659;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vu/KYm0KtD2vkEd5L0JojkkS2QIaDn1D1f6ZazfHu0w=;
 b=jmG0tfzt/l8WHn8sReErPwH6tWVsef8rNEppKUctq6glhE6gBo1CC1U+TS2mgyKtMA
 qxpaeTIHJmSnbSySaNq8NL8bi2TKKGJESa5fXDsmZZxhTzC2wdFz9UIHLp/ZQmMvAAB9
 h18YRy1jTmJvjoMuGvJYgvdrcCImtND+y17rSgreOPUnA9MrzEk2ON6uo0h2T0f7oO9v
 Ie7tRqvBYO1pZDqhlkse7jvErL3cJ5CFq6dDpIO/1tZ0PQSKIt3jgAah9e8DCyGbe1nW
 kFLSU86d33vCNQkDXQW+xtbP71GTJByizoSWQ2i9f2RsUCPGp6C+9+JZKNpplgqKtTRX
 jHVg==
X-Gm-Message-State: AOJu0YzBHrlFlmA4g3NR29txp6RP7LxTORHw957v8w10gomJrZC7Wyav
 qOO0yF5vG0848VxVR4BXBxj4YAtbkYcdnq3CDCGC5wOzR5qKjayCH/7B2FXuw9tWpfYx5tJSbap
 A+A3lMd51vBd1cZW6MtAr2XQXaI4oDBpPKKDO+29E/A==
X-Gm-Gg: Acq92OGC1c+tHt+S7tK5Q6PyDeX8HWSroKRk8THGR5G4Po2EII/tQ1V4JuBV5aV52lA
 1prxmuUxlfw+GXDyhjIW9YnWyMoSife86VMD6v1ZLte3Vh3GHBuz099kDJgud8r8TZn4vnWYB6y
 Sdj2AXMEQlLCnEtVv+MEqOhM6wjeLHZI0n7LFak/3GH+4N9lCuLQESV0DiK4A5Yd33aIIHCmheg
 gxEptxwh3H2On38Tg7YBWHAQRi6kc8ywDRGvqZNNEsYUgAbxa7xddVL3Yx6Nk8O6Azu9nCyTQm7
 p9wLAZlSOaqi0RxNxYTnJiCHW2bFUi9/nQlewWLfmsoWtwZrevNj+hpQ3Ms=
X-Received: by 2002:a05:600c:4e04:b0:490:b9d3:a9ce with SMTP id
 5b1f17b1804b1-490e5640aa8mr10900395e9.30.1781154859207; Wed, 10 Jun 2026
 22:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
 <20260603205152.1440291-6-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260603205152.1440291-6-pierrick.bouvier@oss.qualcomm.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 11 Jun 2026 08:13:53 +0300
X-Gm-Features: AVVi8Ccqbsq3UheQfROKySN3YB4QrOtlBPc0gX1FYoGKa08nC8CozRO-Sxx1g9s
Message-ID: <CAAjaMXZ7-TiDz8AAZqx6sotM9a9V9uQtBnNouGK3gy0PdD=sLg@mail.gmail.com>
Subject: Re: [PATCH 05/25] plugins: remove qemu_plugin_id_t from
 qemu_plugin_udata_cb_t
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Chao Liu <chao.liu.zevorn@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Jun 3, 2026 at 11:52=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> We can now rely on userdata being always available to pass down this id
> if needed.
>
> In our plugins, only tests/tcg/plugins/reset.c was using it.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  contrib/plugins/bbv.c         | 2 +-
>  contrib/plugins/cache.c       | 2 +-
>  contrib/plugins/cflow.c       | 2 +-
>  contrib/plugins/drcov.c       | 2 +-
>  contrib/plugins/execlog.c     | 2 +-
>  contrib/plugins/hotblocks.c   | 2 +-
>  contrib/plugins/hotpages.c    | 2 +-
>  contrib/plugins/howvec.c      | 2 +-
>  contrib/plugins/hwprofile.c   | 2 +-
>  contrib/plugins/ips.c         | 2 +-
>  contrib/plugins/lockstep.c    | 8 ++++----
>  contrib/plugins/stoptrigger.c | 2 +-
>  contrib/plugins/traps.c       | 2 +-
>  contrib/plugins/uftrace.c     | 2 +-
>  include/plugins/qemu-plugin.h | 3 +--
>  plugins/core.c                | 2 +-
>  plugins/loader.c              | 4 ++--
>  tests/tcg/plugins/bb.c        | 2 +-
>  tests/tcg/plugins/inline.c    | 2 +-
>  tests/tcg/plugins/insn.c      | 2 +-
>  tests/tcg/plugins/mem.c       | 2 +-
>  tests/tcg/plugins/reset.c     | 7 ++++---
>  tests/tcg/plugins/syscall.c   | 2 +-
>  23 files changed, 30 insertions(+), 30 deletions(-)
>
> diff --git a/contrib/plugins/bbv.c b/contrib/plugins/bbv.c
> index 5913cc6c637..f2b1b258a90 100644
> --- a/contrib/plugins/bbv.c
> +++ b/contrib/plugins/bbv.c
> @@ -28,7 +28,7 @@ static char *filename;
>  static struct qemu_plugin_scoreboard *vcpus;
>  static uint64_t interval =3D 100000000;
>
> -static void plugin_exit(qemu_plugin_id_t id, void *p)
> +static void plugin_exit(void *p)
>  {
>      Vcpu *vcpu;
>
> diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
> index 56508587d3a..f41ddb0aa43 100644
> --- a/contrib/plugins/cache.c
> +++ b/contrib/plugins/cache.c
> @@ -694,7 +694,7 @@ finish:
>      g_list_free(miss_insns);
>  }
>
> -static void plugin_exit(qemu_plugin_id_t id, void *p)
> +static void plugin_exit(void *p)
>  {
>      log_stats();
>      log_top_insns();
> diff --git a/contrib/plugins/cflow.c b/contrib/plugins/cflow.c
> index b5e33f25f9b..4d00879ccad 100644
> --- a/contrib/plugins/cflow.c
> +++ b/contrib/plugins/cflow.c
> @@ -134,7 +134,7 @@ static gboolean filter_non_branches(gpointer key, gpo=
inter value,
>      return node->dest_count =3D=3D 0;
>  }
>
> -static void plugin_exit(qemu_plugin_id_t id, void *p)
> +static void plugin_exit(void *p)
>  {
>      g_autoptr(GString) result =3D g_string_new("collected ");
>      GList *data;
> diff --git a/contrib/plugins/drcov.c b/contrib/plugins/drcov.c
> index 5edc94dcaf6..458c0d2084d 100644
> --- a/contrib/plugins/drcov.c
> +++ b/contrib/plugins/drcov.c
> @@ -86,7 +86,7 @@ static void count_block(gpointer data, gpointer user_da=
ta)
>      }
>  }
>
> -static void plugin_exit(qemu_plugin_id_t id, void *p)
> +static void plugin_exit(void *p)
>  {
>      unsigned long count =3D 0;
>      g_mutex_lock(&lock);
> diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
> index d00d9c4ff39..d347ac25b6f 100644
> --- a/contrib/plugins/execlog.c
> +++ b/contrib/plugins/execlog.c
> @@ -400,7 +400,7 @@ static void vcpu_init(qemu_plugin_id_t id, unsigned i=
nt vcpu_index)
>  /**
>   * On plugin exit, print last instruction in cache
>   */
> -static void plugin_exit(qemu_plugin_id_t id, void *p)
> +static void plugin_exit(void *p)
>  {
>      guint i;
>      g_rw_lock_reader_lock(&expand_array_lock);
> diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
> index 8ecf0339974..92859872ac9 100644
> --- a/contrib/plugins/hotblocks.c
> +++ b/contrib/plugins/hotblocks.c
> @@ -70,7 +70,7 @@ static void exec_count_free(gpointer key, gpointer valu=
e, gpointer user_data)
>      qemu_plugin_scoreboard_free(cnt->exec_count);
>  }
>
> -static void plugin_exit(qemu_plugin_id_t id, void *p)
> +static void plugin_exit(void *p)
>  {
>      g_autoptr(GString) report =3D g_string_new("collected ");
>      GList *counts, *sorted_counts, *it;
> diff --git a/contrib/plugins/hotpages.c b/contrib/plugins/hotpages.c
> index 9d48ac969eb..a6d83b06c75 100644
> --- a/contrib/plugins/hotpages.c
> +++ b/contrib/plugins/hotpages.c
> @@ -73,7 +73,7 @@ static gint cmp_access_count(gconstpointer a, gconstpoi=
nter b, gpointer d)
>  }
>
>
> -static void plugin_exit(qemu_plugin_id_t id, void *p)
> +static void plugin_exit(void *p)
>  {
>      g_autoptr(GString) report =3D g_string_new("Addr, RCPUs, Reads, WCPU=
s, Writes\n");
>      int i;
> diff --git a/contrib/plugins/howvec.c b/contrib/plugins/howvec.c
> index 42bddb6566d..75728896198 100644
> --- a/contrib/plugins/howvec.c
> +++ b/contrib/plugins/howvec.c
> @@ -172,7 +172,7 @@ static void free_record(gpointer data)
>      g_free(rec);
>  }
>
> -static void plugin_exit(qemu_plugin_id_t id, void *p)
> +static void plugin_exit(void *p)
>  {
>      g_autoptr(GString) report =3D g_string_new("Instruction Classes:\n")=
;
>      int i;
> diff --git a/contrib/plugins/hwprofile.c b/contrib/plugins/hwprofile.c
> index a9838ccc879..b7f96117e94 100644
> --- a/contrib/plugins/hwprofile.c
> +++ b/contrib/plugins/hwprofile.c
> @@ -106,7 +106,7 @@ static void fmt_dev_record(GString *s, DeviceCounts *=
rec)
>      g_string_append_c(s, '\n');
>  }
>
> -static void plugin_exit(qemu_plugin_id_t id, void *p)
> +static void plugin_exit(void *p)
>  {
>      g_autoptr(GString) report =3D g_string_new("");
>      GList *counts;
> diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
> index f110c565bc4..7614ae1eafd 100644
> --- a/contrib/plugins/ips.c
> +++ b/contrib/plugins/ips.c
> @@ -124,7 +124,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct=
 qemu_plugin_tb *tb)
>          quantum_insn, max_insn_per_quantum, NULL);
>  }
>
> -static void plugin_exit(qemu_plugin_id_t id, void *udata)
> +static void plugin_exit(void *udata)
>  {
>      qemu_plugin_scoreboard_free(vcpus);
>  }
> diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
> index 36b003ead2d..c1c2b0aca8e 100644
> --- a/contrib/plugins/lockstep.c
> +++ b/contrib/plugins/lockstep.c
> @@ -77,7 +77,7 @@ static char *path_to_unlink;
>
>  static bool verbose;
>
> -static void plugin_cleanup(qemu_plugin_id_t id, void *userdata)
> +static void plugin_cleanup(void *userdata)
>  {
>      /* Free our block data */
>      g_slist_free_full(blocks, &g_free);
> @@ -90,7 +90,7 @@ static void plugin_cleanup(qemu_plugin_id_t id, void *u=
serdata)
>      }
>  }
>
> -static void plugin_exit(qemu_plugin_id_t id, void *p)
> +static void plugin_exit(void *p)
>  {
>      g_autoptr(GString) out =3D g_string_new("No divergence :-)\n");
>      g_string_append_printf(out, "Executed %ld/%d blocks\n",
> @@ -98,7 +98,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
>      g_string_append_printf(out, "Executed ~%ld instructions\n", insn_cou=
nt);
>      qemu_plugin_outs(out->str);
>
> -    plugin_cleanup(id, NULL);
> +    plugin_cleanup(NULL);
>  }
>
>  /*
> @@ -393,6 +393,6 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugi=
n_id_t id,
>      our_id =3D id;
>
>      qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
> -    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
> +    qemu_plugin_register_atexit_cb(id, plugin_exit, (void *)id);
>      return 0;
>  }
> diff --git a/contrib/plugins/stoptrigger.c b/contrib/plugins/stoptrigger.=
c
> index b3a6ed66a7b..40f8fd313d7 100644
> --- a/contrib/plugins/stoptrigger.c
> +++ b/contrib/plugins/stoptrigger.c
> @@ -93,7 +93,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct q=
emu_plugin_tb *tb)
>      }
>  }
>
> -static void plugin_exit(qemu_plugin_id_t id, void *p)
> +static void plugin_exit(void *p)
>  {
>      g_hash_table_destroy(addrs_ht);
>      qemu_plugin_scoreboard_free(insn_count_sb);
> diff --git a/contrib/plugins/traps.c b/contrib/plugins/traps.c
> index a741580fbf8..4b879a8212a 100644
> --- a/contrib/plugins/traps.c
> +++ b/contrib/plugins/traps.c
> @@ -44,7 +44,7 @@ static void vcpu_discon(qemu_plugin_id_t id, unsigned i=
nt vcpu_index,
>      }
>  }
>
> -static void plugin_exit(qemu_plugin_id_t id, void *p)
> +static void plugin_exit(void *p)
>  {
>      g_autoptr(GString) report;
>      report =3D g_string_new("VCPU, interrupts, exceptions, hostcalls\n")=
;
> diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
> index f974090e23e..a071a34ea75 100644
> --- a/contrib/plugins/uftrace.c
> +++ b/contrib/plugins/uftrace.c
> @@ -928,7 +928,7 @@ static void vcpu_end(unsigned int vcpu_index)
>      memset(cpu, 0, sizeof(Cpu));
>  }
>
> -static void at_exit(qemu_plugin_id_t id, void *data)
> +static void at_exit(void *data)
>  {
>      bool system_emulation =3D (bool) data;
>      g_autoptr(GArray) traces =3D g_array_new(0, 0, sizeof(Trace *));
> diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.=
h
> index 3c6f32bacfe..d7d972103cb 100644
> --- a/include/plugins/qemu-plugin.h
> +++ b/include/plugins/qemu-plugin.h
> @@ -142,11 +142,10 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plu=
gin_id_t id,
>
>  /**
>   * typedef qemu_plugin_udata_cb_t - callback with user data
> - * @id: the unique qemu_plugin_id_t
>   * @userdata: a pointer to some user data supplied when the callback
>   * was registered.
>   */
> -typedef void (*qemu_plugin_udata_cb_t)(qemu_plugin_id_t id, void *userda=
ta);
> +typedef void (*qemu_plugin_udata_cb_t)(void *userdata);
>
>  /**
>   * typedef qemu_plugin_vcpu_simple_cb_t - vcpu callback
> diff --git a/plugins/core.c b/plugins/core.c
> index 21a3c5b15cf..b0532e8d0de 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -147,7 +147,7 @@ static void plugin_cb__udata(enum qemu_plugin_event e=
v)
>          QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
>              qemu_plugin_udata_cb_t func =3D cb->f.udata;
>
> -            func(cb->ctx->id, cb->udata);
> +            func(cb->udata);
>          }
>          break;
>      default:
> diff --git a/plugins/loader.c b/plugins/loader.c
> index 0d587c344c4..b10ebe8cc05 100644
> --- a/plugins/loader.c
> +++ b/plugins/loader.c
> @@ -339,7 +339,7 @@ static void plugin_reset_destroy__locked(struct qemu_=
plugin_reset_data *data)
>      if (data->reset) {
>          g_assert(ctx->resetting);
>          if (data->cb) {
> -            data->cb(ctx->id, data->userdata);
> +            data->cb(data->userdata);
>          }
>          ctx->resetting =3D false;
>          g_free(data);
> @@ -358,7 +358,7 @@ static void plugin_reset_destroy__locked(struct qemu_=
plugin_reset_data *data)
>      g_assert(success);
>      QTAILQ_REMOVE(&plugin.ctxs, ctx, entry);
>      if (data->cb) {
> -        data->cb(ctx->id, data->userdata);
> +        data->cb(data->userdata);
>      }
>      if (!g_module_close(ctx->handle)) {
>          warn_report("%s: %s", __func__, g_module_error());
> diff --git a/tests/tcg/plugins/bb.c b/tests/tcg/plugins/bb.c
> index 36776dee1e1..8a854408aaa 100644
> --- a/tests/tcg/plugins/bb.c
> +++ b/tests/tcg/plugins/bb.c
> @@ -40,7 +40,7 @@ static void gen_one_cpu_report(CPUCount *count, GString=
 *report,
>      }
>  }
>
> -static void plugin_exit(qemu_plugin_id_t id, void *p)
> +static void plugin_exit(void *p)
>  {
>      g_autoptr(GString) report =3D g_string_new("");
>
> diff --git a/tests/tcg/plugins/inline.c b/tests/tcg/plugins/inline.c
> index 73dde995781..1d17884b40b 100644
> --- a/tests/tcg/plugins/inline.c
> +++ b/tests/tcg/plugins/inline.c
> @@ -121,7 +121,7 @@ static void stats_mem(void)
>      g_assert(inl_per_vcpu =3D=3D expected);
>  }
>
> -static void plugin_exit(qemu_plugin_id_t id, void *udata)
> +static void plugin_exit(void *udata)
>  {
>      const unsigned int num_cpus =3D qemu_plugin_num_vcpus();
>      g_autoptr(GString) stats =3D g_string_new("");
> diff --git a/tests/tcg/plugins/insn.c b/tests/tcg/plugins/insn.c
> index e6c5207cd69..12421054f67 100644
> --- a/tests/tcg/plugins/insn.c
> +++ b/tests/tcg/plugins/insn.c
> @@ -190,7 +190,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct=
 qemu_plugin_tb *tb)
>      }
>  }
>
> -static void plugin_exit(qemu_plugin_id_t id, void *p)
> +static void plugin_exit(void *p)
>  {
>      g_autoptr(GString) out =3D g_string_new(NULL);
>      int i;
> diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
> index 6b0732dc0fd..5cdf71c7e49 100644
> --- a/tests/tcg/plugins/mem.c
> +++ b/tests/tcg/plugins/mem.c
> @@ -68,7 +68,7 @@ static gint addr_order(gconstpointer a, gconstpointer b=
, gpointer d)
>  }
>
>
> -static void plugin_exit(qemu_plugin_id_t id, void *p)
> +static void plugin_exit(void *p)
>  {
>      g_autoptr(GString) out =3D g_string_new("");
>
> diff --git a/tests/tcg/plugins/reset.c b/tests/tcg/plugins/reset.c
> index 6ea675b8095..ef5a32781b2 100644
> --- a/tests/tcg/plugins/reset.c
> +++ b/tests/tcg/plugins/reset.c
> @@ -14,7 +14,7 @@ static qemu_plugin_id_t plugin_id;
>  static bool was_reset;
>  static bool was_uninstalled;
>
> -static void after_uninstall(qemu_plugin_id_t id, void *userdata)
> +static void after_uninstall(void *userdata)
>  {
>      g_assert(was_reset && !was_uninstalled);
>      qemu_plugin_outs("uninstall done\n");
> @@ -34,8 +34,9 @@ static void tb_trans_after_reset(qemu_plugin_id_t id, s=
truct qemu_plugin_tb *tb)
>                                           QEMU_PLUGIN_CB_NO_REGS, NULL);
>  }
>
> -static void after_reset(qemu_plugin_id_t id, void *userdata)
> +static void after_reset(void *userdata)
>  {
> +    qemu_plugin_id_t id =3D (qemu_plugin_id_t) userdata;
>      g_assert(!was_reset && !was_uninstalled);
>      qemu_plugin_outs("reset done\n");
>      was_reset =3D true;
> @@ -45,7 +46,7 @@ static void after_reset(qemu_plugin_id_t id, void *user=
data)
>  static void tb_exec_before_reset(unsigned int vcpu_index, void *userdata=
)
>  {
>      g_assert(!was_reset && !was_uninstalled);
> -    qemu_plugin_reset(plugin_id, after_reset, NULL);
> +    qemu_plugin_reset(plugin_id, after_reset, (void *) plugin_id);
>  }
>
>  static void tb_trans_before_reset(qemu_plugin_id_t id, struct qemu_plugi=
n_tb *tb)
> diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
> index 5658f830879..938646f9359 100644
> --- a/tests/tcg/plugins/syscall.c
> +++ b/tests/tcg/plugins/syscall.c
> @@ -207,7 +207,7 @@ static gint comp_func(gconstpointer ea, gconstpointer=
 eb, gpointer d)
>  }
>
>  /* *********************************************************************=
**** */
> -static void plugin_exit(qemu_plugin_id_t id, void *p)
> +static void plugin_exit(void *p)
>  {
>      if (!statistics) {
>          return;
> --
> 2.43.0
>
>

