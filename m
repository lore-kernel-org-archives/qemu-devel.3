Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90410C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 15:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNub-0005wy-DC; Fri, 26 Jan 2024 10:14:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rTNuT-0005uS-CY
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 10:14:25 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rTNuQ-0002Ow-CB
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 10:14:24 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40e913e3f03so7745515e9.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 07:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706282061; x=1706886861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tEgUiso/gqEWntgDkK1RUcIR5FswJ9EKO+qEa+rec3o=;
 b=JHgtOBfFt5qA6WHUl5GqOhAyrqdWuBOn1lcJF96PUT5eshU6CkJyHv9fttFDNLDefU
 poKjnNhVsS9oG2BixXZ7OqeidXI8emXx95x/KI6Mx4bmIwHVD0XAk6kQw19xdXy5GVQC
 ncwnv65dvxvZt3CiR626Nq7J1gCU1sHv3wryU9Hr+4lKbsyndpNeKPiig9zVpmN+Is9z
 lCC9KKuKQ7bwUrCTQW2EtLc/z0orL/vKC0TGGOnYKzHLrnMVPZYQWuS6a9FzpVKDmGF5
 KuQHSDtPkM+tBMqbFzCdsQkPM6YrcMTaQoTCJrjN5eaCJu1Gin+MGrqg5EoUjAh5J8kH
 hEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706282061; x=1706886861;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tEgUiso/gqEWntgDkK1RUcIR5FswJ9EKO+qEa+rec3o=;
 b=IuPUceyGm/XL3m4c+I+9mCrVf/s3tprFXObd2GlyokuiOjHIKTeCEFlSvR5DeA/654
 WmZkT97fcnmpYpmRWaB8H8fbIeeLNmgWSGCvYN2zDChURmBUvbCrlPKKnYz5o6YUZ+Qo
 bvZXHpy+ChO4UGrSTF2ihiGYXDtw5tOfJMYshccKBku1bfwM3+WJ7bYkhRt6rnielNzA
 RP+ERXfqQD3CE9Je4EdRLg2V/nLqNFBaTXCfKfx+6w76KG72zOrf4d5JhJP0CY5P6alK
 ovS7a7ZIcCGZ9AAuzGQ0FWomuj3VP39bX6kVtwsJ1T+h1q1CKslCUxjdT5vli494bCgD
 Fusg==
X-Gm-Message-State: AOJu0Yw36EStbeqe153cl1AtL8rHU6DSVG3RduqclPU7JC26HZAGni8r
 PrkGoKsEB00/9VRMIMyUV9++ELzogj4qDGZ/Bh98HKXxRrM68pAaKzHqXuC/oo4=
X-Google-Smtp-Source: AGHT+IFztlehBWZM55IzQmuXIMo4xtpCfJ/Cl5VvWN2J52W/s0h/usmLRXY2XZpi4a6IgPT/RPKDHA==
X-Received: by 2002:a05:600c:4f82:b0:40d:92c4:c2da with SMTP id
 n2-20020a05600c4f8200b0040d92c4c2damr1053264wmq.31.1706282060631; 
 Fri, 26 Jan 2024 07:14:20 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 fa7-20020a056000258700b00338914eb90dsm1469247wrb.82.2024.01.26.07.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 07:14:20 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DBDDB5F78A;
 Fri, 26 Jan 2024 15:14:19 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH v2 02/14] plugins: scoreboard API
In-Reply-To: <20240118032400.3762658-3-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Thu, 18 Jan 2024 07:23:47 +0400")
References: <20240118032400.3762658-1-pierrick.bouvier@linaro.org>
 <20240118032400.3762658-3-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Fri, 26 Jan 2024 15:14:19 +0000
Message-ID: <87il3grut0.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> We introduce a cpu local storage, automatically managed (and extended)
> by QEMU itself. Plugin allocate a scoreboard, and don't have to deal
> with how many cpus are launched.
>
> This API will be used by new inline functions but callbacks can benefit
> from this as well. This way, they can operate without a global lock for
> simple operations.
>
> New functions:
> - qemu_plugin_scoreboard_free
> - qemu_plugin_scoreboard_get
> - qemu_plugin_scoreboard_new
> - qemu_plugin_scoreboard_size
>
> In more, we define a qemu_plugin_u64_t, which is a simple struct holding
> a pointer to a scoreboard, and a given offset.
> This allows to have a scoreboard containing structs, without having to
> bring offset for all operations on a specific field.
>
> Since most of the plugins are simply collecting a sum of per-cpu values,
> qemu_plugin_u64_t directly support this operation as well.
>
> New functions:
> - qemu_plugin_u64_get
> - qemu_plugin_u64_sum
> New macros:
> - qemu_plugin_u64
> - qemu_plugin_u64_struct
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  include/qemu/plugin.h        |  7 +++
>  include/qemu/qemu-plugin.h   | 75 ++++++++++++++++++++++++++++
>  plugins/api.c                | 39 +++++++++++++++
>  plugins/core.c               | 97 ++++++++++++++++++++++++++++++++++++
>  plugins/plugin.h             |  8 +++
>  plugins/qemu-plugins.symbols |  6 +++
>  6 files changed, 232 insertions(+)
>
> diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
> index 9346249145d..5f340192e56 100644
> --- a/include/qemu/plugin.h
> +++ b/include/qemu/plugin.h
> @@ -115,6 +115,13 @@ struct qemu_plugin_insn {
>      bool mem_only;
>  };
>=20=20
> +/* A scoreboard is an array of values, indexed by vcpu_index */
> +struct qemu_plugin_scoreboard {
> +    GArray *data;
> +    size_t size;

Can we get size from GArray->len itself?

> +    size_t element_size;
> +};
> +
>  /*
>   * qemu_plugin_insn allocate and cleanup functions. We don't expect to
>   * cleanup many of these structures. They are reused for each fresh
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index 2c1930e7e45..934059d64c2 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -220,6 +220,23 @@ void qemu_plugin_register_vcpu_resume_cb(qemu_plugin=
_id_t id,
>  struct qemu_plugin_tb;
>  /** struct qemu_plugin_insn - Opaque handle for a translated instruction=
 */
>  struct qemu_plugin_insn;
> +/**
> + * struct qemu_plugin_scoreboard - Opaque handle for a scoreboard
> + *
> + * A scoreboard is an array of data, indexed by vcpu_index.
> + **/

stray *'s - I think this is what trips up kdoc.

> +struct qemu_plugin_scoreboard;
> +
> +/**
> + * qemu_plugin_u64_t - uint64_t member of an entry in a scoreboard

We generally reserve lower_case_with_underscores_ending_with_a_t for
scalar types. Its also a little generic. Maybe qemu_plugin_scoreboard_ref?

> + *
> + * This field allows to access a specific uint64_t member in one given e=
ntry,
> + * located at a specified offset. Inline operations expect this as entry.
> + */
> +typedef struct qemu_plugin_u64 {

I don't think you need the forward declaration here (which clashes later
on).

> +    struct qemu_plugin_scoreboard *score;
> +    size_t offset;
> +} qemu_plugin_u64_t;
>=20=20
>  /**
>   * enum qemu_plugin_cb_flags - type of callback
> @@ -754,5 +771,63 @@ int qemu_plugin_read_register(unsigned int vcpu,
>                                struct qemu_plugin_register *handle,
>                                GByteArray *buf);
>=20=20
> +/**
> + * qemu_plugin_scoreboard_new() - alloc a new scoreboard
> + *
> + * Returns a pointer to a new scoreboard. It must be freed using
> + * qemu_plugin_scoreboard_free.
> + */
> +QEMU_PLUGIN_API
> +struct qemu_plugin_scoreboard *qemu_plugin_scoreboard_new(size_t element=
_size);
> +
> +/**
> + * qemu_plugin_scoreboard_free() - free a scoreboard
> + * @score: scoreboard to free
> + */
> +QEMU_PLUGIN_API
> +void qemu_plugin_scoreboard_free(struct qemu_plugin_scoreboard *score);
> +
> +/**
> + * qemu_plugin_scoreboard_size() - return size of a scoreboard
> + * @score: scoreboard to query
> + */
> +QEMU_PLUGIN_API
> +size_t qemu_plugin_scoreboard_size(struct qemu_plugin_scoreboard
> *score);

Is this actually host memory size related? The use case in the plugins
seems to be a proxy for num_cpus and I'm note sure we want it used that
way. We are making the contract that it will always be big enough for
the number of vcpus created - maybe that is the helper we need?

> +
> +/**
> + * qemu_plugin_scoreboard_get() - access value from a scoreboard
> + * @score: scoreboard to query
> + * @vcpu_index: entry index
> + *
> + * Returns address of entry of a scoreboard matching a given vcpu_index.=
 This
> + * address can be modified later if scoreboard is resized.
> + */
> +QEMU_PLUGIN_API
> +void *qemu_plugin_scoreboard_get(struct qemu_plugin_scoreboard *score,
> +                                 unsigned int vcpu_index);
> +
> +/* Macros to define a qemu_plugin_u64_t */
> +#define qemu_plugin_u64(score) \
> +    (qemu_plugin_u64_t){score, 0}
> +#define qemu_plugin_u64_struct(score, type, member) \
> +    (qemu_plugin_u64_t){score, offsetof(type, member)}

qemu_plugin_val_ref and qemu_plugin_struct_ref?

> +
> +/**
> + * qemu_plugin_u64_get() - access specific uint64_t in a scoreboard
> + * @entry: entry to query
> + * @vcpu_index: entry index
> + *
> + * Returns address of a specific member in a scoreboard entry, matching =
a given
> + * vcpu_index.
> + */
> +QEMU_PLUGIN_API
> +uint64_t *qemu_plugin_u64_get(qemu_plugin_u64_t entry, unsigned int vcpu=
_index);
> +
> +/**
> + * qemu_plugin_u64_sum() - return sum of all values in a scoreboard
> + * @entry: entry to sum
> + */
> +QEMU_PLUGIN_API
> +uint64_t qemu_plugin_u64_sum(qemu_plugin_u64_t entry);
>=20=20
>  #endif /* QEMU_QEMU_PLUGIN_H */
> diff --git a/plugins/api.c b/plugins/api.c
> index e777eb4e9fc..4de94e798c6 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -547,3 +547,42 @@ static void __attribute__((__constructor__)) qemu_ap=
i_init(void)
>      qemu_mutex_init(&reg_handle_lock);
>=20=20
>  }
> +
> +struct qemu_plugin_scoreboard *qemu_plugin_scoreboard_new(size_t element=
_size)
> +{
> +    return plugin_scoreboard_new(element_size);
> +}
> +
> +void qemu_plugin_scoreboard_free(struct qemu_plugin_scoreboard *score)
> +{
> +    plugin_scoreboard_free(score);
> +}
> +
> +size_t qemu_plugin_scoreboard_size(struct qemu_plugin_scoreboard *score)
> +{
> +    return score->size;

So this would be score->data->len

> +}
> +
> +void *qemu_plugin_scoreboard_get(struct qemu_plugin_scoreboard *score,
> +                                 unsigned int vcpu_index)
> +{
> +    g_assert(vcpu_index < qemu_plugin_scoreboard_size(score));
> +    char *ptr =3D score->data->data;
> +    return ptr + vcpu_index * score->element_size;

GArray has accesses functions for this:

       return &g_array_index(score->data,
                             g_array_get_element_size(score->data),
                             vcpu_index);
=20=20
> +}
> +
> +uint64_t *qemu_plugin_u64_get(qemu_plugin_u64_t entry,
> +                                         unsigned int vcpu_index)
> +{
> +    char *ptr =3D (char *) qemu_plugin_scoreboard_get(entry.score, vcpu_=
index);
> +    return (uint64_t *)(ptr + entry.offset);

Not sure whats going with the casting here but I wonder if we are giving
the user too much rope. Why not to return the value itself? In fact why
do we treat things as an offset rather than an index of uint64_t.

The qemu_plugin_scoreboard_get can return uint64_t * and the individual
get becomes:


  uint64_t *qemu_plugin_scoreboard_get(struct qemu_plugin_scoreboard *score,
                                       unsigned int vcpu_index)
  {
      g_assert(vcpu_index < qemu_plugin_scoreboard_size(score));
      return &g_array_index(score->data, score->element_size, vcpu_index);
  }

  uint64_t qemu_plugin_u64_get(struct qemu_plugin_scoreboard *score,
                                unsigned int vcpu_index, unsigned int score=
_index)
  {
      g_assert(score_index < score->num_elements);
      uint64_t *sb =3D qemu_plugin_scoreboard_get(score, vcpu_index);
      return sb[score_index];
  }

> +}
> +
> +uint64_t qemu_plugin_u64_sum(qemu_plugin_u64_t entry)
> +{
> +    uint64_t total =3D 0;
> +    for (int i =3D 0; i < qemu_plugin_scoreboard_size(entry.score); ++i)=
 {
> +        total +=3D *qemu_plugin_u64_get(entry, i);
> +    }
> +    return total;
> +}
> diff --git a/plugins/core.c b/plugins/core.c
> index e07b9cdf229..0286a127810 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -209,6 +209,71 @@ plugin_register_cb_udata(qemu_plugin_id_t id, enum q=
emu_plugin_event ev,
>      do_plugin_register_cb(id, ev, func, udata);
>  }
>=20=20
> +struct resize_scoreboard_args {
> +    size_t new_alloc_size;
> +    size_t new_size;
> +};
> +
> +static void plugin_resize_one_scoreboard(gpointer key,
> +                                         gpointer value,
> +                                         gpointer user_data)
> +{
> +    struct qemu_plugin_scoreboard *score =3D
> +        (struct qemu_plugin_scoreboard *) value;
> +    struct resize_scoreboard_args *args =3D
> +        (struct resize_scoreboard_args *) user_data;
> +    if (score->data->len !=3D args->new_alloc_size) {
> +        g_array_set_size(score->data, args->new_alloc_size);
> +    }
> +    score->size =3D args->new_size;

I think you have this in len so if you skip the extra field you can just
do:

  new_size =3D GPOINTER_TO_UINT(user_data);

> +}
> +
> +static void plugin_grow_scoreboards__locked(CPUState *cpu)
> +{
> +    if (cpu->cpu_index < plugin.scoreboard_size) {
> +        return;
> +    }
> +
> +    bool need_realloc =3D FALSE;
> +    while (cpu->cpu_index >=3D plugin.scoreboard_alloc_size) {
> +        plugin.scoreboard_alloc_size *=3D 2;

I suspect for USER this makes sense, if we every end up doing system
expansion then it would just be +1 at a time. In fact given glib does:

      gsize want_alloc =3D g_nearest_pow (g_array_elt_len (array, want_len)=
);

maybe we just do a simple increment and leave it up glib to handle the
exponential growth?


> +        need_realloc =3D TRUE;
> +    }
> +    plugin.scoreboard_size =3D cpu->cpu_index + 1;
> +    g_assert(plugin.scoreboard_size <=3D plugin.scoreboard_alloc_size);
> +
> +    if (g_hash_table_size(plugin.scoreboards) =3D=3D 0) {
> +        /* nothing to do, we just updated sizes for future scoreboards */
> +        return;
> +    }
> +
> +    if (need_realloc) {
> +#ifdef CONFIG_USER_ONLY
> +        /**
> +         * cpus must be stopped, as some tb might still use an existing
> +         * scoreboard.
> +         */
> +        start_exclusive();
> +#endif

Hmm this seems wrong to be USER_ONLY. While we don't expect to resize in
system mode if we did we certainly want to do it during exclusive
periods.

> +    }
> +
> +    struct resize_scoreboard_args args =3D {
> +        .new_alloc_size =3D plugin.scoreboard_alloc_size,
> +        .new_size =3D plugin.scoreboard_size
> +    };
> +    g_hash_table_foreach(plugin.scoreboards,
> +                         &plugin_resize_one_scoreboard,
> +                         &args);

This can just be g_hash_table_foreach(plugin.scoreboards,
                                      &plugin_resize_one_scoreboard,
                                      GUINT_TO_POINTER(plugin.scoreboard_al=
loc_size))

> +
> +    if (need_realloc) {
> +        /* force all tb to be flushed, as scoreboard pointers were chang=
ed. */
> +        tb_flush(cpu);
> +#ifdef CONFIG_USER_ONLY
> +        end_exclusive();
> +#endif
> +    }
> +}
> +
>  void qemu_plugin_vcpu_init_hook(CPUState *cpu)
>  {
>      bool success;
> @@ -218,6 +283,7 @@ void qemu_plugin_vcpu_init_hook(CPUState *cpu)
>      success =3D g_hash_table_insert(plugin.cpu_ht, &cpu->cpu_index,
>                                    &cpu->cpu_index);
>      g_assert(success);
> +    plugin_grow_scoreboards__locked(cpu);
>      qemu_rec_mutex_unlock(&plugin.lock);
>=20=20
>      plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_INIT);
> @@ -576,8 +642,39 @@ static void __attribute__((__constructor__)) plugin_=
init(void)
>      qemu_rec_mutex_init(&plugin.lock);
>      plugin.id_ht =3D g_hash_table_new(g_int64_hash, g_int64_equal);
>      plugin.cpu_ht =3D g_hash_table_new(g_int_hash, g_int_equal);
> +    plugin.scoreboards =3D g_hash_table_new(g_int64_hash, g_int64_equal);
> +    plugin.scoreboard_size =3D 1;
> +    plugin.scoreboard_alloc_size =3D 16; /* avoid frequent reallocation =
*/
>      QTAILQ_INIT(&plugin.ctxs);
>      qht_init(&plugin.dyn_cb_arr_ht, plugin_dyn_cb_arr_cmp, 16,
>               QHT_MODE_AUTO_RESIZE);
>      atexit(qemu_plugin_atexit_cb);
>  }
> +
> +struct qemu_plugin_scoreboard *plugin_scoreboard_new(size_t element_size)
> +{
> +    struct qemu_plugin_scoreboard *score =3D
> +        g_malloc0(sizeof(struct qemu_plugin_scoreboard));
> +    score->data =3D g_array_new(FALSE, TRUE, element_size);
> +    g_array_set_size(score->data, plugin.scoreboard_alloc_size);
> +    score->size =3D plugin.scoreboard_size;
> +    score->element_size =3D element_size;
> +
> +    qemu_rec_mutex_lock(&plugin.lock);
> +    bool inserted =3D g_hash_table_insert(plugin.scoreboards, score, sco=
re);
> +    g_assert(inserted);
> +    qemu_rec_mutex_unlock(&plugin.lock);
> +
> +    return score;
> +}
> +
> +void plugin_scoreboard_free(struct qemu_plugin_scoreboard *score)
> +{
> +    qemu_rec_mutex_lock(&plugin.lock);
> +    bool removed =3D g_hash_table_remove(plugin.scoreboards, score);
> +    g_assert(removed);
> +    qemu_rec_mutex_unlock(&plugin.lock);
> +
> +    g_array_free(score->data, TRUE);
> +    g_free(score);
> +}
> diff --git a/plugins/plugin.h b/plugins/plugin.h
> index 2c278379b70..99829c40886 100644
> --- a/plugins/plugin.h
> +++ b/plugins/plugin.h
> @@ -31,6 +31,10 @@ struct qemu_plugin_state {
>       * but with the HT we avoid adding a field to CPUState.
>       */
>      GHashTable *cpu_ht;
> +    /* Scoreboards, indexed by their addresses. */
> +    GHashTable *scoreboards;
> +    size_t scoreboard_size;
> +    size_t scoreboard_alloc_size;
>      DECLARE_BITMAP(mask, QEMU_PLUGIN_EV_MAX);
>      /*
>       * @lock protects the struct as well as ctx->uninstalling.
> @@ -99,4 +103,8 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
>=20=20
>  void exec_inline_op(struct qemu_plugin_dyn_cb *cb, int cpu_index);
>=20=20
> +struct qemu_plugin_scoreboard *plugin_scoreboard_new(size_t element_size=
);
> +
> +void plugin_scoreboard_free(struct qemu_plugin_scoreboard *score);
> +
>  #endif /* PLUGIN_H */
> diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
> index 6963585c1ea..93866d1b5f2 100644
> --- a/plugins/qemu-plugins.symbols
> +++ b/plugins/qemu-plugins.symbols
> @@ -38,10 +38,16 @@
>    qemu_plugin_register_vcpu_tb_exec_inline;
>    qemu_plugin_register_vcpu_tb_trans_cb;
>    qemu_plugin_reset;
> +  qemu_plugin_scoreboard_free;
> +  qemu_plugin_scoreboard_get;
> +  qemu_plugin_scoreboard_new;
> +  qemu_plugin_scoreboard_size;
>    qemu_plugin_start_code;
>    qemu_plugin_tb_get_insn;
>    qemu_plugin_tb_n_insns;
>    qemu_plugin_tb_vaddr;
> +  qemu_plugin_u64_get;
> +  qemu_plugin_u64_sum;
>    qemu_plugin_uninstall;
>    qemu_plugin_vcpu_for_each;
>  };

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

